import 'package:flutter/material.dart';

/// [BottomSheetPage] to use [ModalBottomSheetRoute] in routes
class BottomSheetPage<T> extends Page<T> {
  final Widget? page;
  final BottomSheet? bottomSheet;
  final VoidCallback? onClosing;

  const BottomSheetPage(
      {this.bottomSheet, this.page, this.onClosing, super.key});

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute(
        settings: this,
        builder: (context) =>
            bottomSheet ??
            BottomSheet(
              builder: (_) => SafeArea(child: page ?? const SizedBox()),
              onClosing: onClosing ?? () => {},
            ),
        isScrollControlled: true,
      );
}
