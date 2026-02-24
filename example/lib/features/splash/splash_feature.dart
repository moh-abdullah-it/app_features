import 'dart:developer';

import 'package:app_features/app_features.dart';
import 'package:example/features/splash/splash_page.dart';

/// Demonstrates: async initialization via [Feature.init]
class SplashFeature extends Feature {
  @override
  String get name => '/';

  /// Simulates async configuration loading before the router is built.
  /// Called automatically by [AppFeatures.configAsync].
  @override
  Future<void> init() async {
    log('[SplashFeature] init — loading configuration...');
    await Future.delayed(const Duration(seconds: 2));
    log('[SplashFeature] init — complete');
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const SplashPage(),
        ),
      ];
}
