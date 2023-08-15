import 'package:app_features/app_features.dart';
import 'package:example/features/out/out_page.dart';

class OutFeature extends Feature {
  @override
  String get name => '/out';

  @override
  List<GoRoute> get routes =>
      [GoRoute(path: name, name: name, builder: (_, __) => const OutPage())];
}
