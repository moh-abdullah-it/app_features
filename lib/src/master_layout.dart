import 'package:app_features/app_features.dart';
import 'package:app_features/src/pages/master_page.dart';
import 'package:flutter/material.dart';

/// [BottomNavigationBuilder] to build bottom nav with route shell
typedef BottomNavigationBuilder = Widget Function(
    StatefulNavigationShell navigationShell);

/// abstract [MasterLayout] implement main layout
abstract class MasterLayout {
  List<Feature> get features;

  String? _currentName;

  StatefulShellRouteBuilder? get masterPageBuilder => null;

  BottomNavigationBuilder? get bottomNavigationBar => null;

  /// restoration scope id for the shell route
  String? get restorationScopeId => null;

  /// top-level redirect for the shell route
  GoRouterRedirect? get redirect => null;

  /// parent navigator key for the shell route
  GlobalKey<NavigatorState>? get parentNavigatorKey => null;

  /// custom navigator container builder; when provided, uses
  /// StatefulShellRoute() instead of StatefulShellRoute.indexedStack()
  ShellNavigationContainerBuilder? get navigatorContainerBuilder => null;

  modifyListener(GoRouterState state, StatefulNavigationShell navigationShell) {
    Feature feature = features[navigationShell.currentIndex];
    if (_currentName != null && _currentName != feature.name) {
      feature.emit(feature.name, null, null, state);
    }
    _currentName = feature.name;
  }

  RouteBase getShellRoute() {
    final branches = features.map((Feature f) {
      return StatefulShellBranch(
        navigatorKey: f.navigatorKey,
        routes: f.routes,
        initialLocation: f.branchInitialLocation,
        restorationScopeId: f.branchRestorationScopeId,
        observers: f.branchObservers,
        preload: f.preloadBranch,
      );
    }).toList();

    final builder = masterPageBuilder ??
        (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          modifyListener(state, navigationShell);
          return MasterPage(
            navigationShell: navigationShell,
            bottomNavigationBar: bottomNavigationBar,
          );
        };

    if (navigatorContainerBuilder != null) {
      return StatefulShellRoute(
        branches: branches,
        redirect: redirect,
        builder: builder,
        parentNavigatorKey: parentNavigatorKey,
        restorationScopeId: restorationScopeId,
        navigatorContainerBuilder: navigatorContainerBuilder!,
      );
    }

    return StatefulShellRoute.indexedStack(
      builder: builder,
      branches: branches,
      redirect: redirect,
      parentNavigatorKey: parentNavigatorKey,
      restorationScopeId: restorationScopeId,
    );
  }
}
