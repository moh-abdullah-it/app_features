import 'package:app_features/app_features.dart';
import 'package:app_features/src/pages/master_page.dart';
import 'package:flutter/material.dart';

/// [BottomNavigationBuilder] to build bottom nav with route shell
typedef BottomNavigationBuilder = Widget Function(
    StatefulNavigationShell navigationShell);

/// abstract [MasterLayout] implement main layout
abstract class MasterLayout {
  List<Feature> get features;

  StatefulShellRouteBuilder? get masterPageBuilder => null;

  BottomNavigationBuilder? get bottomNavigationBar => null;

  RouteBase getShellRoute() => StatefulShellRoute.indexedStack(
      builder: masterPageBuilder ??
          (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return MasterPage(
              navigationShell: navigationShell,
              bottomNavigationBar: bottomNavigationBar,
            );
          },
      branches: features.map((Feature f) {
        return StatefulShellBranch(
          navigatorKey: f.navigatorKey,
          routes: f.routes,
        );
      }).toList());
}
