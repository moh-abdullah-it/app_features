import 'package:app_features/app_features.dart';
import 'package:example/features/home/home_feature.dart';
import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_add_alt_1,
                  size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              Text('Create Account',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'This page is a nested sub-feature of AuthFeature,\n'
                'auto-registered via subFeatures getter.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  AuthService.login();
                  AppFeatures.emit('user_logged_in', data: 'NewUser');
                  AppFeatures.get<HomeFeature>().go();
                  AppFeatures.scaffoldMessenger
                      .showSuccessMessage('Registered successfully');
                },
                icon: const Icon(Icons.check),
                label: const Text('Complete Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
