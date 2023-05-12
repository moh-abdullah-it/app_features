import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title Home'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => AppFeatures.pop(),
          child: const Text('back'),
        ),
      )
    );
  }
}
