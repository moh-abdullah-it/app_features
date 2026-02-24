import 'package:app_features/app_features.dart';
import 'package:example/features/auth/auth_page.dart';
import 'package:example/features/auth/register_page.dart';

/// Demonstrates: nested features via [subFeatures]
class AuthFeature extends Feature {
  @override
  String get name => '/auth';

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const AuthPage(),
        ),
      ];

  /// Nested features — RegisterFeature is auto-registered as a sub-feature
  @override
  List<Feature> get subFeatures => [
        RegisterFeature(),
      ];
}

/// Sub-feature of [AuthFeature] — registered automatically via [subFeatures].
/// Access it with: AppFeatures.get<RegisterFeature>().push()
class RegisterFeature extends Feature {
  @override
  String get name => '/auth/register';

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const RegisterPage(),
        ),
      ];
}
