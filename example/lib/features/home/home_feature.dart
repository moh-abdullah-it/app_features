import 'dart:developer';

import 'package:app_features/app_features.dart';
import 'package:example/features/home/home_page.dart';
import 'package:example/features/home/pages/test_bottom_sheet_page.dart';
import 'package:example/features/home/pages/test_dialog_page.dart';

/// Demonstrates: middleware (onEnter/onLeave), multi-listener events,
/// dialog/bottom sheet routes
class HomeFeature extends Feature {
  @override
  String get name => '/home';

  String get dialog => '/home/testDialog';
  String get bottomSheet => '/home/testBottomSheet';

  /// Multi-listener — multiple callbacks registered on the same route name
  @override
  listen() {
    on(name, (pathParams, queryParams, extra) {
      log('[HomeFeature] listener 1: home opened');
    });
    on(name, (pathParams, queryParams, extra) {
      log('[HomeFeature] listener 2: analytics logged');
    });
  }

  /// Middleware — fires when entering this feature
  @override
  void onEnter(GoRouterState state) {
    log('[HomeFeature] onEnter: ${state.matchedLocation}');
  }

  /// Middleware — fires when leaving this feature
  @override
  void onLeave(GoRouterState state) {
    log('[HomeFeature] onLeave: ${state.matchedLocation}');
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const HomePage(),
        ),
        GoRoute(
          path: dialog,
          name: dialog,
          pageBuilder: (context, state) => DialogPage(
            page: TestDialogPage(
                message: state.extra as String? ?? 'Hello from dialog route!'),
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: bottomSheet,
          name: bottomSheet,
          pageBuilder: (context, state) => BottomSheetPage(
            page: const TestBottomSheetPage(),
            key: state.pageKey,
            isScrollControlled: true,
            showDragHandle: true,
          ),
        ),
      ];

  void openDialog({String? message}) =>
      push(name: dialog, extra: message ?? 'Dialog via route navigation');

  void openBottomSheet() => push(name: bottomSheet);
}
