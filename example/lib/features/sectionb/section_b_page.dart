import 'package:app_features/app_features.dart';
import 'package:example/features/home/home_feature.dart';
import 'package:flutter/material.dart';

class SectionBPage extends StatelessWidget {
  const SectionBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section B'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => AppFeatures.get<HomeFeature>().openInHome(),
            child: const Text('In Home'),
          ),
        ],
      ),
    );
  }
}
