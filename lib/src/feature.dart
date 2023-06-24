import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

abstract class Feature {
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
  }) =>
      AppFeatures.router.pushNamed(name ?? this.name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  /// route replace name
  /// AppFeature.get<HomeFeature>().replace()
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

  /// route go name
  /// AppFeature.get<HomeFeature>().go()
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
