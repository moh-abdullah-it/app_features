import 'package:flutter/material.dart';

import '../../app_features.dart';

abstract class NotificationsUtils{
  static void showSnackBar({
    SnackBar? snackBar,
    Widget? content,
    Color? backgroundColor}) => ScaffoldMessenger.of(AppFeatures.router.routerDelegate.navigatorKey.currentContext!)
      .showSnackBar(snackBar ??
      SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(8),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: content,
          )));

  static void showSuccessMessage(String message) => showSnackBar(
      content: Text(message,
        style: const TextStyle(
            color: Colors.white),
      ),
      backgroundColor: Colors.green.shade400);

  static void showErrorMessage(String message) => showSnackBar(
      content: Text(message,
        style: const TextStyle(
            color: Colors.white),
      ),
      backgroundColor: Colors.red.shade400);

  static void showToast(String message) => showSnackBar(
      content: Text(message,
        style: const TextStyle(
            color: Colors.black),
      ),
      backgroundColor: Colors.blueGrey.shade200);
}