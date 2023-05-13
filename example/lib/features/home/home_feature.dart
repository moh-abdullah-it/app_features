import 'package:app_features/app_features.dart';
import 'package:example/features/home/pages/test_bottom_sheet_page.dart';
import 'package:example/features/home/pages/test_dialog_page.dart';

import 'home_page.dart';

class HomeFeature extends Feature {
  @override
  void get dependencies => () => {};

  @override
  String get name => '/home';

  String get dialog => '/home/testDialog';

  String get bottomSheet => '/home/testBottomSheet';

  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const HomePage(),
        ),
        GoRoute(
            path: dialog,
            name: dialog,
            pageBuilder: (context, state) =>
                DialogPage(page: const TestDialogPage(), key: state.pageKey)),
        GoRoute(
            path: bottomSheet,
            name: bottomSheet,
            pageBuilder: (context, state) => BottomSheetPage(
                page: const TestBottomSheetPage(), key: state.pageKey)),
      ];
  void openDialog() => push(name: dialog);
  void openBottomSheet() => push(name: bottomSheet);
}
