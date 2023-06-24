import 'package:app_features/app_features.dart';
import 'package:example/app/widgets/bottom_nav.dart';
import 'package:example/features/home/home_feature.dart';

class AppMasterLayout extends MasterLayout {
  @override
  List<Feature> get features => [HomeFeature()];

  @override
  BottomNavigationBuilder get bottomNavigationBar =>
      (shellRoute) => BottomNav(shellRoute);
}
