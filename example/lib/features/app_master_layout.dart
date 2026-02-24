import 'package:app_features/app_features.dart';
import 'package:example/app/widgets/bottom_nav.dart';
import 'package:example/features/explore/explore_feature.dart';
import 'package:example/features/home/home_feature.dart';

/// [Shell Route Config] — MasterLayout with custom configuration
class AppMasterLayout extends MasterLayout {
  @override
  List<Feature> get features => [
        HomeFeature(),
        ExploreFeature(),
      ];

  @override
  BottomNavigationBuilder get bottomNavigationBar =>
      (shellRoute) => BottomNav(shellRoute);

  /// [Shell Config] — restoration scope for state preservation
  @override
  String? get restorationScopeId => 'main_shell';

  /// [Shell Config] — notify root observers on shell navigation changes
  @override
  bool get notifyRootObserver => true;
}
