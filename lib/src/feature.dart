import 'package:app_features/app_features.dart';

abstract class Feature {
  String get name;

  List<GoRoute> get routes;

  void get dependencies => () => {};

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
}
