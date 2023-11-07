import 'package:app_features/app_features.dart';
import 'package:example/features/sectionb/section_b_page.dart';

class SectionBFeature extends Feature {
  SectionBFeature() {
    on(name,
        (pathParameters, queryParameters, extra) => print('SectionBFeature'));
  }

  @override
  String get name => '/sectionB';

  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: name,
          name: name,
          builder: (_, __) => const SectionBPage(),
        )
      ];
}
