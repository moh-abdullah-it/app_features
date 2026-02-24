import 'dart:async';
import 'dart:developer';

import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

typedef Callback = dynamic Function(Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters, Object? extra);

abstract class Feature {
  final Map<String, List<Callback>> _subscriptions =
      <String, List<Callback>>{};

  listen() {}

  /// name of feature and use it as path
  /// use it to open feature AppFeature.get<HomeFeature>().push()
  String get name;

  /// list of feature routes
  List<RouteBase> get routes;

  /// feature navigator key
  GlobalKey<NavigatorState> get navigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: runtimeType.toString());

  /// feature dependencies
  void get dependencies => () => {};

  /// Async initialization hook. Called once during [AppFeatures.configAsync].
  /// Override to perform async setup (database, services, etc.)
  Future<void> init() async {}

  /// Route-level redirect for this feature.
  /// Return a path to redirect, or null to allow navigation.
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) => null;

  /// Called when any route of this feature is entered.
  void onEnter(GoRouterState state) {}

  /// Called when leaving any route of this feature.
  void onLeave(GoRouterState state) {}

  /// Sub-features owned by this feature. Registered automatically
  /// when the parent feature is registered.
  List<Feature> get subFeatures => [];

  /// whether to preload this branch when used in MasterLayout
  bool get preloadBranch => false;

  /// initial location for this branch in MasterLayout
  String? get branchInitialLocation => null;

  /// navigator observers for this branch in MasterLayout
  List<NavigatorObserver>? get branchObservers => null;

  /// restoration scope id for this branch in MasterLayout
  String? get branchRestorationScopeId => null;

  /// route push name
  /// AppFeature.get<HomeFeature>().push()
  Future<T?> push<T extends Object?>({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    emit(name ?? this.name, pathParameters, queryParameters, extra);
    return AppFeatures.router.pushNamed<T>(name ?? this.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  /// route replace name
  /// AppFeature.get<HomeFeature>().replace()
  Future<T?> replace<T>({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    emit(name ?? this.name, pathParameters, queryParameters, extra);

    return AppFeatures.router.replaceNamed<T>(name ?? this.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  /// route pushReplace name
  /// AppFeature.get<HomeFeature>().replace()
  Future<T?> pushReplacement<T extends Object?>({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    emit(name ?? this.name, pathParameters, queryParameters, extra);

    return AppFeatures.router.pushReplacementNamed<T>(name ?? this.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  /// route go name
  /// AppFeature.get<HomeFeature>().go()
  void go({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
    String? fragment,
  }) {
    emit(name ?? this.name, pathParameters, queryParameters, extra);

    return AppFeatures.router.goNamed(name ?? this.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
        fragment: fragment);
  }

  /// route push by path
  Future<T?> pushPath<T extends Object?>(String path, {Object? extra}) {
    return AppFeatures.router.push<T>(path, extra: extra);
  }

  /// route go by path
  void goPath(String path, {Object? extra}) {
    AppFeatures.router.go(path, extra: extra);
  }

  /// route replace by path
  Future<T?> replacePath<T>(String path, {Object? extra}) {
    return AppFeatures.router.replace<T>(path, extra: extra);
  }

  /// route pushReplacement by path
  Future<T?> pushReplacementPath<T extends Object?>(String path,
      {Object? extra}) {
    return AppFeatures.router.pushReplacement<T>(path, extra: extra);
  }

  /// Merges feature-level redirect with route-level redirect.
  /// Feature redirect runs first; if it returns null, the route redirect runs.
  GoRouterRedirect _mergeRedirects(GoRouterRedirect? routeRedirect) {
    return (BuildContext context, GoRouterState state) async {
      final featureResult = await redirect(context, state);
      if (featureResult != null) return featureResult;
      if (routeRedirect != null && context.mounted) {
        return routeRedirect(context, state);
      }
      return null;
    };
  }

  List<RouteBase> routesWithRootKey(GlobalKey<NavigatorState> rootNavigatorKey) {
    return routes.map((RouteBase e) {
      if (e is GoRoute) {
        return GoRoute(
          path: e.path,
          name: e.name,
          parentNavigatorKey: rootNavigatorKey,
          builder: e.builder,
          pageBuilder: e.pageBuilder,
          redirect: _mergeRedirects(e.redirect),
          onExit: e.onExit,
          caseSensitive: e.caseSensitive,
          routes: e.routes,
        );
      }
      return e;
    }).toList();
  }

  /// Register a callback for a route name.
  /// Multiple callbacks per name are supported.
  void on(String name, Callback callback) {
    _subscriptions.putIfAbsent(name, () => []);
    _subscriptions[name]!.add(callback);
  }

  /// Remove a specific callback for a route name.
  void off(String name, Callback callback) {
    _subscriptions[name]?.remove(callback);
  }

  /// Remove all callbacks for a route name.
  void offAll(String name) {
    _subscriptions.remove(name);
  }

  Future<List> emit(String name, Map<String, String>? pathParameters,
      Map<String, dynamic>? queryParameters, Object? extra) {
    log('current route name: $name');
    var results = <Future>[];
    final callbacks = _subscriptions[name];
    if (callbacks != null) {
      for (final callback in callbacks) {
        var result = callback(pathParameters, queryParameters, extra);
        results.add(result is Future ? result : Future(() => result));
      }
    }
    return Future.wait(results);
  }
}
