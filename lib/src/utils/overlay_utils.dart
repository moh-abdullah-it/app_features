import 'package:app_features/src/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../app_features.dart';

/// [OverlayUtils] modify support to use overlay with route [BuildContext]
class OverlayUtils {
  BuildContext? _context;

  OverlayUtils.of(GoRouter router) {
    _context = router.routerDelegate.navigatorKey.currentContext;
  }

  /// open dialog with overlay
  openDialog(
    Widget child, {
    bool isDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) =>
      showDialog(
          context: _context!,
          builder: (context) => child,
          barrierDismissible: isDismissible,
          barrierLabel: barrierLabel,
          useSafeArea: useSafeArea,
          useRootNavigator: useRootNavigator,
          routeSettings: routeSettings,
          anchorPoint: anchorPoint,
          traversalEdgeBehavior: traversalEdgeBehavior);

  /// open ModalBottomSheet with overlay
  openModalBottomSheet(Widget child,
          {Color? backgroundColor,
          double? elevation,
          ShapeBorder? shape,
          Clip? clipBehavior,
          BoxConstraints? constraints,
          Color? barrierColor,
          bool isScrollControlled = false,
          bool useRootNavigator = false,
          bool isDismissible = true,
          bool enableDrag = true,
          bool? showDragHandle,
          bool useSafeArea = false,
          RouteSettings? routeSettings,
          AnimationController? transitionAnimationController,
          Offset? anchorPoint}) =>
      showModalBottomSheet(
          context: _context!,
          builder: (context) => child,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          clipBehavior: clipBehavior,
          constraints: constraints,
          barrierColor: barrierColor,
          isScrollControlled: isScrollControlled,
          useRootNavigator: useRootNavigator,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          showDragHandle: showDragHandle,
          useSafeArea: useSafeArea,
          routeSettings: routeSettings,
          transitionAnimationController: transitionAnimationController,
          anchorPoint: anchorPoint);

  /// open BottomSheet
  openBottomSheet(Widget child,
          {Color? backgroundColor,
          double? elevation,
          ShapeBorder? shape,
          Clip? clipBehavior,
          BoxConstraints? constraints,
          bool enableDrag = true,
          AnimationController? transitionAnimationController}) =>
      showBottomSheet(
        context: _context!,
        builder: (context) => child,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        enableDrag: enableDrag,
        transitionAnimationController: transitionAnimationController,
      );

  /// show simple loading
  showLoading({Widget? child = const LoadingWidget()}) => openDialog(child!);
}
