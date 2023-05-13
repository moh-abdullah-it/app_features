import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Widget? page;
  final Dialog? dialog;
  final VoidCallback? onClosing;
  final bool dismissible;
  final Color backgroundColor;
  final double elevation;

  const DialogPage({
    this.dialog,
    this.page,
    this.onClosing,
    this.dismissible = true,
    this.backgroundColor = Colors.white,
    this.elevation = 8.0,
    super.key});

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute(
    barrierDismissible: dismissible,
    settings: this,
    builder: (context) => dialog ?? Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      child: page,
    ),
    context: context,
  );
}
