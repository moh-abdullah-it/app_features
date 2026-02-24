import 'package:app_features/app_features.dart';
import 'package:example/features/home/home_feature.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 2),
        () => AppFeatures.get<HomeFeature>().go(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.apps, size: 80,
                color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 24),
            Text('App Features Demo',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Async init completed — loading splash...',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
