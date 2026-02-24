import 'dart:developer';

import 'package:app_features/app_features.dart';
import 'package:example/features/explore/explore_page.dart';

/// Demonstrates: branch config (preload, restoration scope), middleware
class ExploreFeature extends Feature {
  @override
  String get name => '/explore';

  /// Branch config — preload this branch when master layout first loads
  @override
  bool get preloadBranch => true;

  /// Branch config — restoration scope id for state preservation
  @override
  String? get branchRestorationScopeId => 'explore_branch';

  /// Middleware — fires when entering this feature
  @override
  void onEnter(GoRouterState state) {
    log('[ExploreFeature] onEnter: ${state.matchedLocation}');
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const ExplorePage(),
        ),
      ];
}
