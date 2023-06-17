import 'package:app_features/app_features.dart';
import 'package:example/features/app_master_layout.dart';
import 'package:example/features/splash/splash_feature.dart';
import 'package:flutter/material.dart';

void main() {
  AppFeatures.config(
    features: [
      SplashFeature(),
    ],
    masterLayout: AppMasterLayout(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Features Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppFeatures.router,
    );
  }
}
