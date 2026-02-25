import 'dart:convert';

import 'package:app_features/src/utils/overlay_utils.dart';
import 'package:app_features/src/utils/scaffold_messenger_utils.dart';
import 'package:flutter/material.dart';

import '../app_features.dart';

/// Callback type for global event bus
typedef EventCallback = void Function(Object? data);

final Map<String, Feature> _featuresMap = {};
List<RouteBase> _routes = [];
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter _router = GoRouter(routes: []);

/// Tracks the currently active feature for middleware (onEnter/onLeave)
Feature? _activeFeature;

/// Global event bus for cross-feature communication
final Map<String, List<EventCallback>> _globalEvents = {};

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
    _setupMiddleware();
  }

  /// Async version of [config] that awaits all feature [Feature.init] methods.
  /// Use when features need async initialization (database, SDK, etc.)
  static Future<void> configAsync({
    required List<Feature> features,
    MasterLayout? masterLayout,
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
  }) async {
    register(features);
    if (masterLayout != null) {
      _routes.add(masterLayout.getShellRoute());
      register(masterLayout.features, needRegisterRoutes: false);
    }
    _routes.addAll(appRoutes ?? []);

    // Await async init for all features in parallel
    final allFeatures = <Feature>[..._featuresMap.values];
    await Future.wait(allFeatures.map((f) => f.init()));

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
    _setupMiddleware();
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

      // Register sub-features automatically
      if (feature.subFeatures.isNotEmpty) {
        register(feature.subFeatures, needRegisterRoutes: needRegisterRoutes);
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
  static void registerRoutes(Feature feature) {
    _routes.addAll(feature.routesWithRootKey(_rootNavigatorKey));
  }

  /// Sets up middleware that triggers [Feature.onEnter] and [Feature.onLeave]
  static void _setupMiddleware() {
    _router.routerDelegate.addListener(() {
      final currentLocation = _router.state.matchedLocation;
      final newFeature = _findFeatureForLocation(currentLocation);

      if (newFeature != _activeFeature) {
        _activeFeature?.onLeave(_router.state);
        newFeature?.onEnter(_router.state);
        _activeFeature = newFeature;
      }
    });
  }

  /// Find which feature owns the current route by matching the longest name prefix
  static Feature? _findFeatureForLocation(String location) {
    Feature? bestMatch;
    int bestLength = 0;
    for (var feature in _featuresMap.values) {
      if (location.startsWith(feature.name) &&
          feature.name.length > bestLength) {
        bestMatch = feature;
        bestLength = feature.name.length;
      }
    }
    return bestMatch;
  }

  // ── Global Event Bus ──

  /// Register a global event listener for cross-feature communication.
  static void on(String event, EventCallback callback) {
    _globalEvents.putIfAbsent(event, () => []);
    _globalEvents[event]!.add(callback);
  }

  /// Remove a specific global event listener.
  static void off(String event, EventCallback callback) {
    _globalEvents[event]?.remove(callback);
  }

  /// Emit a global event to all listeners.
  static void emit(String event, {Object? data}) {
    final callbacks = _globalEvents[event];
    if (callbacks != null) {
      for (final callback in callbacks) {
        callback(data);
      }
    }
  }

  /// Remove all listeners for a global event.
  static void offAll(String event) {
    _globalEvents.remove(event);
  }

  /// Clear all global event listeners.
  static void clearEvents() {
    _globalEvents.clear();
  }

  // ── Router Access ──

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
