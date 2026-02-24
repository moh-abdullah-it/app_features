import 'package:app_features/app_features.dart';
import 'package:example/features/app_master_layout.dart';
import 'package:example/features/auth/auth_feature.dart';
import 'package:example/features/settings/settings_feature.dart';
import 'package:example/features/splash/splash_feature.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [Async Init] — awaits all Feature.init() before building the router.
  /// SplashFeature.init() simulates loading config/data.
  await AppFeatures.configAsync(
    features: [
      SplashFeature(),
      AuthFeature(), // has subFeatures: [RegisterFeature]
      SettingsFeature(), // protected by feature guard (redirect)
    ],
    masterLayout: AppMasterLayout(),

    /// [GoRouter Params] — all GoRouter constructor params are supported
    debugLogDiagnostics: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Features Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      routerConfig: AppFeatures.router,
    );
  }
}
