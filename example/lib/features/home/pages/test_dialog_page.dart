import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

class TestDialogPage extends StatelessWidget {
  final String message;
  const TestDialogPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dialog Route'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 8),
          Text(
            'This dialog is a GoRoute using DialogPage',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => AppFeatures.pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
