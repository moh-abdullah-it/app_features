import 'package:app_features/app_features.dart';
import 'package:app_features/src/pages/master_page.dart';
import 'package:flutter/material.dart';

typedef BottomNavigationBuildr = Widget Function(
    StatefulNavigationShell navigationShell);

abstract class MasterLayout {
  List<Feature> get features;

  StatefulShellRouteBuilder? get masterPageBuilder => null;

  BottomNavigationBuildr get bottomNavigationBar;

  List<RouteBase> getRoutes() => <RouteBase>[
        StatefulShellRoute.indexedStack(
            builder: masterPageBuilder ??
                (BuildContext context, GoRouterState state,
                    StatefulNavigationShell navigationShell) {
                  return MasterPage(
                    navigationShell: navigationShell,
                    bottomNavigationBar: bottomNavigationBar,
                  );
                },
            branches: features
                .map((Feature f) => StatefulShellBranch(
                      navigatorKey: f.navigatorKey,
                      routes: f.routes,
                    ))
                .toList()),
      ];
}
