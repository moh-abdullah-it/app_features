
import 'package:app_features/app_features.dart';

import 'home_page.dart';

class HomeFeature extends Feature{
  @override
  void get dependencies => () => {

  };

  @override
  String get name => '/home';

  @override
  List<GoRoute> get routes => [
    GoRoute(
        path: name,
        name: name,
        builder: (_, __) => const HomePage())
  ];

}