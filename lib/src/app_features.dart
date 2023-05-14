import 'package:app_features/src/config/app_routes.dart';
import 'package:app_features/src/utils/scaffold_messenger_utils.dart';
import 'package:flutter/material.dart';

import '../app_features.dart';

final Map<String, Feature> _featuresMap = {};
List<GoRoute> _routes = [];
GoRouter _router = GoRouter(routes: _routes);

class AppFeatures {
  List<Feature> features = [];
  AppFeatures.config(
      {required this.features,
      Widget? loadingWidget,
      List<GoRoute>? appRoutes}) {
    register(features);
    _routes.add(loadingRoute(loadingWidget: loadingWidget));
    _routes.addAll(appRoutes ?? []);
  }

  init({Function? init}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (init != null) {
      await init();
    }
  }

  static T get<T extends Object>() {
    if (_featuresMap.containsKey(T.toString())) {
      return _featuresMap[T.toString()] as T;
    }
    throw Exception("Future ${T.toString()} Not Found");
  }

  static void _register(Feature feature) {
    if (!_featuresMap.containsKey(feature.runtimeType.toString())) {
      _featuresMap[feature.runtimeType.toString()] = feature;
      feature.dependencies;
      registerRoutes(feature);
    }
  }

  /// Inject All Your Features
  static void register(List<Feature> list) {
    list.forEach(_register);
  }

  static registerRoutes(Feature feature) {
    _routes.addAll(feature.routes);
  }

  static GoRouter get router => _router;

  static void pop() => router.pop();

  static void showLoading() => router.push(loadingPath);

  static void hideLoading() => pop();

  static void showSuccessMessage(String message) =>
      ScaffoldMessengerUtils.of(router).showSuccessMessage(message);

  static void showErrorMessage(String message) =>
      ScaffoldMessengerUtils.of(router).showErrorMessage(message);

  static void showToast(String message) =>
      ScaffoldMessengerUtils.of(router).showToast(message);

  static void showSnackBar(
          {SnackBar? snackBar, Widget? content, Color? backgroundColor}) =>
      ScaffoldMessengerUtils.of(router).showSnackBar(
          snackBar: snackBar,
          content: content,
          backgroundColor: backgroundColor);
}
