import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

// Simple [MasterLayout] page
class MasterPage extends StatelessWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// [BottomNavigationBuilder]
  final BottomNavigationBuilder bottomNavigationBar;

  const MasterPage(
      {Key? key,
      required this.navigationShell,
      required this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: bottomNavigationBar(navigationShell),
    );
  }
}
