import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final StatefulNavigationShell shellRoute;
  const BottomNav(this.shellRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: shellRoute.currentIndex,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
      ],
      onDestinationSelected: (index) => shellRoute.goBranch(index),
    );
  }
}
