import 'dart:async';

import 'package:app_features/app_features.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';

/// Demonstrates: feature guard via [redirect]
///
/// This feature is a top-level (non-master) feature, so its routes go through
/// [routesWithRootKey] where the feature-level redirect is merged in.
class SettingsFeature extends Feature {
  @override
  String get name => '/settings';

  /// Feature-level guard — redirects to /auth if not logged in.
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (!AuthService.isLoggedIn) return '/auth';
    return null;
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const SettingsPage(),
        ),
      ];
}
