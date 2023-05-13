import 'package:flutter/material.dart';

import '../../app_features.dart';

class ScaffoldMessengerUtils {
  BuildContext? _context;
  ScaffoldMessengerUtils.of(GoRouter router) {
    _context = router.routerDelegate.navigatorKey.currentContext;
  }

  void showSnackBar(
          {SnackBar? snackBar, Widget? content, Color? backgroundColor}) =>
      ScaffoldMessenger.of(_context!).showSnackBar(snackBar ??
          SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: backgroundColor,
              margin: const EdgeInsets.all(8),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: content,
              )));

  void showSuccessMessage(String message) => showSnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade400);

  void showErrorMessage(String message) => showSnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red.shade400);

  void showToast(String message) => showSnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.blueGrey.shade200);
}
