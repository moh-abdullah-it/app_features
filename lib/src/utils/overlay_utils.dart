import 'package:flutter/material.dart';

import '../../app_features.dart';

class OverlayUtils {
  BuildContext? _context;
  OverlayUtils.of(GoRouter router) {
    _context = router.routerDelegate.navigatorKey.currentContext;
  }

  showMDialog(
    Widget child, {
    bool dismissible = true,
    bool useRootNavigator = true,
  }) =>
      showDialog(
        context: _context!,
        barrierDismissible: dismissible,
        useRootNavigator: useRootNavigator,
        builder: (context) => child,
      );

  showBottomSheet(Widget child,
          {bool dismissible = true,
          bool useRootNavigator = true,
          bool isScrollControlled = true,
          Color? backgroundColor,
          double? elevation,
          ShapeBorder? shape}) =>
      showModalBottomSheet(
        context: _context!,
        useRootNavigator: useRootNavigator,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        isScrollControlled: isScrollControlled,
        builder: (context) => child,
      );
}
