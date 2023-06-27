import 'package:flutter/material.dart';

/// [BottomSheetPage] to use [ModalBottomSheetRoute] in routes
class BottomSheetPage<T> extends Page<T> {
  final Widget? page;
  final BottomSheet? bottomSheet;
  final VoidCallback? onClosing;

  /// Stores a list of captured [InheritedTheme]s that are wrapped around the
  /// bottom sheet.
  ///
  /// Consider setting this attribute when the [ModalBottomSheetRoute]
  /// is created through [Navigator.push] and its friends.
  final CapturedThemes? capturedThemes;

  /// Specifies whether this is a route for a bottom sheet that will utilize
  /// [DraggableScrollableSheet].
  ///
  /// Consider setting this parameter to true if this bottom sheet has
  /// a scrollable child, such as a [ListView] or a [GridView],
  /// to have the bottom sheet be draggable.
  final bool isScrollControlled;

  /// The bottom sheet's background color.
  ///
  /// Defines the bottom sheet's [Material.color].
  ///
  /// If this property is not provided, it falls back to [Material]'s default.
  final Color? backgroundColor;

  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material.
  ///
  /// Defaults to 0, must not be negative.
  final double? elevation;

  /// The shape of the bottom sheet.
  ///
  /// Defines the bottom sheet's [Material.shape].
  ///
  /// If this property is not provided, it falls back to [Material]'s default.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defines the bottom sheet's [Material.clipBehavior].
  ///
  /// Use this property to enable clipping of content when the bottom sheet has
  /// a custom [shape] and the content can extend past this shape. For example,
  /// a bottom sheet with rounded corners and an edge-to-edge [Image] at the
  /// top.
  ///
  /// If this property is null, the [BottomSheetThemeData.clipBehavior] of
  /// [ThemeData.bottomSheetTheme] is used. If that's null, the behavior defaults to [Clip.none]
  /// will be [Clip.none].
  final Clip? clipBehavior;

  /// Defines minimum and maximum sizes for a [BottomSheet].
  ///
  /// Typically a bottom sheet will cover the entire width of its
  /// parent. Consider limiting the width by setting smaller constraints
  /// for large screens.
  ///
  /// If null, the ambient [ThemeData.bottomSheetTheme]'s
  /// [BottomSheetThemeData.constraints] will be used. If that
  /// is null, the bottom sheet's size will be constrained
  /// by its parent (usually a [Scaffold]).
  ///
  /// If constraints are specified (either in this property or in the
  /// theme), the bottom sheet will be aligned to the bottom-center of
  /// the available space. Otherwise, no alignment is applied.
  final BoxConstraints? constraints;

  /// Specifies the color of the modal barrier that darkens everything below the
  /// bottom sheet.
  ///
  /// Defaults to `Colors.black54` if not provided.
  final Color? modalBarrierColor;

  /// Specifies whether the bottom sheet will be dismissed
  /// when user taps on the scrim.
  ///
  /// If true, the bottom sheet will be dismissed when user taps on the scrim.
  ///
  /// Defaults to true.
  final bool isDismissible;

  /// Specifies whether the bottom sheet can be dragged up and down
  /// and dismissed by swiping downwards.
  ///
  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// This applies to the content below the drag handle, if showDragHandle is true.
  ///
  /// Defaults is true.
  final bool enableDrag;

  /// Specifies whether a drag handle is shown.
  ///
  /// The drag handle appears at the top of the bottom sheet. The default color is
  /// [ColorScheme.onSurfaceVariant] with an opacity of 0.4 and can be customized
  /// using dragHandleColor. The default size is `Size(32,4)` and can be customized
  /// with dragHandleSize.
  ///
  /// If null, then the value of  [BottomSheetThemeData.showDragHandle] is used. If
  /// that is also null, defaults to false.
  final bool? showDragHandle;

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController? transitionAnimationController;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  /// Whether to avoid system intrusions on the top, left, and right.
  ///
  /// If true, a [SafeArea] is inserted to keep the bottom sheet away from
  /// system intrusions at the top, left, and right sides of the screen.
  ///
  /// If false, the bottom sheet isn't exposed to the top padding of the
  /// MediaQuery.
  ///
  /// In either case, the bottom sheet extends all the way to the bottom of
  /// the screen, including any system intrusions.
  ///
  /// The default is false.
  final bool useSafeArea;

  /// {@template flutter.material.ModalBottomSheetRoute.barrierOnTapHint}
  /// The semantic hint text that informs users what will happen if they
  /// tap on the widget. Announced in the format of 'Double tap to ...'.
  ///
  /// If the field is null, the default hint will be used, which results in
  /// announcement of 'Double tap to activate'.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [barrierDismissible], which controls the behavior of the barrier when
  ///    tapped.
  ///  * [ModalBarrier], which uses this field as onTapHint when it has an onTap action.
  final String? barrierOnTapHint;

  const BottomSheetPage(
      {this.capturedThemes,
      this.isScrollControlled = true,
      this.backgroundColor,
      this.elevation,
      this.shape,
      this.clipBehavior,
      this.constraints,
      this.modalBarrierColor,
      this.isDismissible = true,
      this.enableDrag = true,
      this.showDragHandle,
      this.transitionAnimationController,
      this.anchorPoint,
      this.useSafeArea = true,
      this.barrierOnTapHint,
      this.bottomSheet,
      this.page,
      this.onClosing,
      super.key});

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute(
        settings: this,
        builder: (context) =>
            bottomSheet ??
            BottomSheet(
              builder: (_) => SafeArea(child: page ?? const SizedBox()),
              onClosing: onClosing ?? () => {},
            ),
        capturedThemes: capturedThemes,
        isScrollControlled: isScrollControlled,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        modalBarrierColor: modalBarrierColor,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        showDragHandle: showDragHandle,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint,
        useSafeArea: useSafeArea,
        barrierOnTapHint: barrierOnTapHint,
      );
}
