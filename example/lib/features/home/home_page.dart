import 'package:app_features/app_features.dart';
import 'package:example/features/home/home_feature.dart';
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
            onPressed: () => AppFeatures.pop(),
            child: const Text('back'),
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
              AppFeatures.showLoading(),
              Future.delayed(const Duration(seconds: 5), () => AppFeatures.hideLoading())
            },
            child: const Text('showLoading'),
          ),
        ],
      )
    );
  }
}
