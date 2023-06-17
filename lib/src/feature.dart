import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

abstract class Feature {
  String get name;

  List<GoRoute> get routes;

  GlobalKey<NavigatorState> get navigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: runtimeType.toString());

  void get dependencies => () => {};

  BottomNavigationBarItem? get bottomNavigationBarItem => null;

  Future<T?> push<T extends Object?>({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      AppFeatures.router.pushNamed(name ?? this.name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  void replace({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      AppFeatures.router.replaceNamed(name ?? this.name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  void go({
    String? name,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      AppFeatures.router.goNamed(name ?? this.name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);
}
