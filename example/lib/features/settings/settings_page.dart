import 'package:app_features/app_features.dart';
import 'package:example/features/auth/auth_feature.dart';
import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Feature Guard',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text(
                    'This page is protected by a feature-level redirect. '
                    'If you are not logged in, you are redirected to /auth.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () {
              AuthService.logout();
              AppFeatures.emit('user_logged_out');
              AppFeatures.get<AuthFeature>().go();
              AppFeatures.scaffoldMessenger.showSuccessMessage('Logged out');
            },
            child: const Text('Logout'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => AppFeatures.pop(),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
