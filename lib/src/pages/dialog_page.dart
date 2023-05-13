import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Widget? page;
  final Dialog? dialog;
  final VoidCallback? onClosing;

  const DialogPage({this.dialog, this.page, this.onClosing, super.key});

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute(
    settings: this,
    builder: (context) => dialog ?? Dialog(
      child: page,
    ),
    context: context,
  );
}
