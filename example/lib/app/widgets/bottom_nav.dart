import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final StatefulNavigationShell shellRoute;
  const BottomNav(
    this.shellRoute, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: shellRoute.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        ],
        onTap: (index) => shellRoute.goBranch(index));
  }
}
