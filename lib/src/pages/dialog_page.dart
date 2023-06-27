import 'package:flutter/material.dart';

/// [DialogPage] to use dialog in routes
class DialogPage<T> extends Page<T> {
  final Widget? page;
  final Dialog? dialog;
  final VoidCallback? onClosing;
  final bool dismissible;
  final Color? backgroundColor;
  final double? elevation;
  final bool useSafeArea;
  final Color? barrierColor;
  final Offset? anchorPoint;

  /// Controls the transfer of focus beyond the first and the last items of a
  /// [FocusScopeNode].
  ///
  /// If set to null, [Navigator.routeTraversalEdgeBehavior] is used.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  const DialogPage(
      {this.useSafeArea = true,
      this.dialog,
      this.page,
      this.onClosing,
      this.dismissible = true,
      this.backgroundColor = Colors.white,
      this.elevation = 8.0,
      this.barrierColor,
      this.anchorPoint,
      this.traversalEdgeBehavior,
      super.key});

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute(
        barrierDismissible: dismissible,
        settings: this,
        builder: (context) =>
            dialog ??
            Dialog(
              backgroundColor: backgroundColor,
              elevation: elevation,
              child: page,
            ),
        context: context,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        anchorPoint: anchorPoint,
        traversalEdgeBehavior: traversalEdgeBehavior,
      );
}
