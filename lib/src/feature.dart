import 'dart:developer';

import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

typedef Callback = dynamic Function(Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters, Object? extra);

abstract class Feature {
  final Map<String, Callback> _subscriptions = <String, Callback>{};

  listen() {}

  /// name of feature and use it as path
  /// use it to open feature AppFeature.get<HomeFeature>().push()
  String get name;

  /// list of feature routes
  List<GoRoute> get routes;

  /// feature navigator key
  GlobalKey<NavigatorState> get navigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: runtimeType.toString());

  /// feature dependencies
  void get dependencies => () => {};

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
  }) {
    emit(name ?? this.name, pathParameters, queryParameters, extra);

    return AppFeatures.router.goNamed(name ?? this.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  routesWithRootKey(rootNavigatorKey) {
    return routes.map((e) {
      return GoRoute(
          path: e.path,
          name: e.name,
          parentNavigatorKey: rootNavigatorKey,
          builder: e.builder,
          pageBuilder: e.pageBuilder,
          redirect: e.redirect,
          routes: e.routes);
    }).toList();
  }

  Future<List> emit(String name, Map<String, String>? pathParameters,
      Map<String, dynamic>? queryParameters, Object? extra) {
    log('current route name: $name');
    var results = <Future>[];
    _subscriptions.forEach((key, Callback subscription) {
      if (key == name) {
        var result = subscription(pathParameters, queryParameters, extra);
        results.add(result is Future ? result : Future(() => result));
      }
    });
    return Future.wait(results);
  }

  on(String name, Callback callback) => _subscriptions[name] = callback;
}
