import 'package:app_features/app_features.dart';
import 'package:example/features/splash/splash_page.dart';

class SplashFeature extends Feature {
  @override
  String get name => '/';

  @override
  List<GoRoute> get routes =>
      [GoRoute(path: name, name: name, builder: (_, __) => const SplashPage())];
}
