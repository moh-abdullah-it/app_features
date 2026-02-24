import 'dart:convert';

import 'package:app_features/src/utils/overlay_utils.dart';
import 'package:app_features/src/utils/scaffold_messenger_utils.dart';
import 'package:flutter/material.dart';

import '../app_features.dart';

final Map<String, Feature> _featuresMap = {};
List<RouteBase> _routes = [];
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter _router = GoRouter(routes: []);

class AppFeatures {
  List<Feature> features = [];
  MasterLayout? masterLayout;

  /// Config All Features With [AppFeatures]
  /// AppFeatures.config(
  /// masterLayout: AppMasterLayout(),
  /// features: [
  ///     SplashFeature(),
  ///     HomeFeature(),
  /// ],
  /// initLocation: '/'
  /// )
  AppFeatures.config({
    required this.features,
    this.masterLayout,
    List<RouteBase>? appRoutes,
    String initLocation = '/',
    GoRouterRedirect? redirect,
    Listenable? refreshListenable,
    GoExceptionHandler? onException,
    GoRouterPageBuilder? errorPageBuilder,
    GoRouterWidgetBuilder? errorBuilder,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    bool routerNeglect = false,
    bool overridePlatformDefaultLocation = false,
    Object? initialExtra,
    int redirectLimit = 5,
    String? restorationScopeId,
    bool requestFocus = true,
    Codec<Object?, Object?>? extraCodec,
  }) {
    register(features);
    if (masterLayout != null) {
      _routes.add(masterLayout!.getShellRoute());
      register(masterLayout!.features, needRegisterRoutes: false);
    }
    _routes.addAll(appRoutes ?? []);
    _router = GoRouter(
      initialLocation: initLocation,
      routes: _routes,
      navigatorKey: _rootNavigatorKey,
      redirect: redirect,
      refreshListenable: refreshListenable,
      onException: onException,
      errorPageBuilder: errorPageBuilder,
      errorBuilder: errorBuilder,
      observers: observers,
      debugLogDiagnostics: debugLogDiagnostics,
      routerNeglect: routerNeglect,
      overridePlatformDefaultLocation: overridePlatformDefaultLocation,
      initialExtra: initialExtra,
      redirectLimit: redirectLimit,
      restorationScopeId: restorationScopeId,
      requestFocus: requestFocus,
      extraCodec: extraCodec,
    );
  }

  /// get feature instance from app feature as singleton
  /// [AppFeatures].get<[HomeFeature]>()
  static T get<T extends Object>() {
    if (_featuresMap.containsKey(T.toString())) {
      return _featuresMap[T.toString()] as T;
    }
    throw Exception("Feature ${T.toString()} Not Found");
  }

  /// register feature in singleton features
  /// call dependencies
  /// register routes
  static void _register(Feature feature, bool needRegisterRoutes) {
    if (!_featuresMap.containsKey(feature.runtimeType.toString())) {
      _featuresMap[feature.runtimeType.toString()] = feature;
      feature.dependencies;
      feature.listen();
      if (needRegisterRoutes) {
        registerRoutes(feature);
      }
    }
  }

  /// register All  Features
  static void register(List<Feature> list, {bool needRegisterRoutes = true}) {
    for (var f in list) {
      _register(f, needRegisterRoutes);
    }
  }

  /// register feature routes
  static registerRoutes(Feature feature) {
    _routes.addAll(feature.routesWithRootKey(_rootNavigatorKey));
  }

  /// go_router instance router config
  static GoRouter get router => _router;

  /// router go back
  /// AppFeature.pop()
  static void pop<T extends Object?>([T? result]) {
    if (canPop()) {
      router.pop(result);
    }
  }

  static bool canPop() => router.canPop();

  /// OverlayUtils incidence
  /// AppFeatures.overlay
  static OverlayUtils get overlay => OverlayUtils.of(router);

  /// ScaffoldMessengerUtils incidence
  /// AppFeatures.scaffoldMessenger
  static ScaffoldMessengerUtils get scaffoldMessenger =>
      ScaffoldMessengerUtils.of(router);

  /// router refresh current rote
  /// AppFeatures.refresh;
  static void get refresh => router.refresh();

  static void restart([String initLocation = '/']) => router.go(initLocation);

  /// Get the named location for a route
  static String namedLocation(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    String? fragment,
  }) =>
      router.namedLocation(name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          fragment: fragment);

  /// Navigate to a path
  static void go(String path, {Object? extra}) =>
      router.go(path, extra: extra);

  /// Push a path onto the navigation stack
  static Future<T?> push<T extends Object?>(String path, {Object? extra}) =>
      router.push<T>(path, extra: extra);

  /// Get the current router state
  static GoRouterState get state => router.state;
}
