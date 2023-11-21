import 'package:app_features/app_features.dart';
import 'package:example/features/home/home_feature.dart';
import 'package:example/features/out/out_feature.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Title Home'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () => AppFeatures.get<OutFeature>().push(),
              child: const Text('Out Home'),
            ),
            TextButton(
              onPressed: () => AppFeatures.restart(),
              child: const Text('Restart'),
            ),
            TextButton(
              onPressed: () => AppFeatures.get<HomeFeature>().openDialog(),
              child: const Text('dialog'),
            ),
            TextButton(
              onPressed: () => AppFeatures.get<HomeFeature>().openBottomSheet(),
              child: const Text('bottomSheet'),
            ),
            TextButton(
              onPressed: () => {
                AppFeatures.overlay.showLoading(),
                Future.delayed(
                    const Duration(seconds: 5), () => AppFeatures.pop())
              },
              child: const Text('showLoading'),
            ),
            TextButton(
              onPressed: () => AppFeatures.scaffoldMessenger
                  .showSuccessMessage('Test Message'),
              child: const Text('showSuccessMessage'),
            ),
            TextButton(
              onPressed: () => AppFeatures.scaffoldMessenger
                  .showErrorMessage('Test Message'),
              child: const Text('showErrorMessage'),
            ),
            TextButton(
              onPressed: () =>
                  AppFeatures.scaffoldMessenger.showToast('Test Message'),
              child: const Text('showToast'),
            ),
          ],
        ));
  }
}
