import 'package:app_features/app_features.dart';
import 'package:example/features/out/out_page.dart';

class OutFeature extends Feature {
  @override
  String get name => '/out';

  @override
  onNavigate(
      {String? name,
      Map<String, String>? pathParameters,
      Map<String, dynamic>? queryParameters,
      Object? extra}) {
    //print('name $name');
  }

  @override
  List<GoRoute> get routes =>
      [GoRoute(path: name, name: name, builder: (_, __) => const OutPage())];
}
