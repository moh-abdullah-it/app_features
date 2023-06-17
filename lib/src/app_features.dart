import 'package:app_features/src/config/app_routes.dart';
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

  AppFeatures.config(
      {required this.features,
      this.masterLayout,
      Widget? loadingWidget,
      List<GoRoute>? appRoutes,
      String initLocation = '/'}) {
    register(features);
    if (masterLayout != null) {
      _routes.addAll(masterLayout!.getRoutes());
      register(masterLayout!.features, needRegisterRoutes: false);
    }
    _routes.add(loadingRoute(loadingWidget: loadingWidget));
    _routes.addAll(appRoutes ?? []);
    _router = GoRouter(
        initialLocation: initLocation,
        routes: _routes,
        navigatorKey: _rootNavigatorKey);
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

  static void _register(Feature feature, bool needRegisterRoutes) {
    if (!_featuresMap.containsKey(feature.runtimeType.toString())) {
      _featuresMap[feature.runtimeType.toString()] = feature;
      feature.dependencies;
      if (needRegisterRoutes) {
        registerRoutes(feature);
      }
    }
  }

  /// Inject All Your Features
  static void register(List<Feature> list, {bool needRegisterRoutes = true}) {
    for (var f in list) {
      _register(f, needRegisterRoutes);
    }
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

  static void showDialog(Widget child) =>
      OverlayUtils.of(router).showMDialog(child);

  static void showBottomSheet(Widget child) =>
      OverlayUtils.of(router).showBottomSheet(child);

  static void refresh = router.refresh();
}
