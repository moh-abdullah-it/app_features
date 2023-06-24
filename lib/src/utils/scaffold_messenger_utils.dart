import 'package:flutter/material.dart';

import '../../app_features.dart';

/// [ScaffoldMessengerUtils] to use [ScaffoldMessenger]
class ScaffoldMessengerUtils {
  BuildContext? _context;
  ScaffoldMessengerUtils.of(GoRouter router) {
    _context = router.routerDelegate.navigatorKey.currentContext;
  }

  /// show snackBar
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

  /// show successMessage
  void showSuccessMessage(String message) => showSnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade400);

  /// show errorMessage
  void showErrorMessage(String message) => showSnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red.shade400);

  /// show toast
  void showToast(String message) => showSnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.blueGrey.shade200);
}
