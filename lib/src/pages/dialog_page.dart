import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Widget? page;
  final Dialog? dialog;
  final VoidCallback? onClosing;
  final bool dismissible;

  const DialogPage({
    this.dialog,
    this.page,
    this.onClosing,
    this.dismissible = true,
    super.key});

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute(
    barrierDismissible: dismissible,
    settings: this,
    builder: (context) => dialog ?? Dialog(
      child: page,
    ),
    context: context,
  );
}
