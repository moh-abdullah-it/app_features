import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

class TestBottomSheetPage extends StatelessWidget {
  const TestBottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Bottom Sheet Route',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(
            'This bottom sheet is a GoRoute using BottomSheetPage.\n'
            'isScrollControlled: true, showDragHandle: true',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => AppFeatures.pop(),
            child: const Text('Close'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
