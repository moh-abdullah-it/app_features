import 'package:app_features/app_features.dart';
import 'package:example/features/sectionb/section_b_page.dart';

class SectionBFeature extends Feature {
  @override
  String get name => '/sectionB';

  @override
  onBranchChange({String? name, GoRouterState? state}) {
    //print('branch change $name');
  }

  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const SectionBPage(),
        )
      ];
}
