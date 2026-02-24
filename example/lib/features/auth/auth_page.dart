import 'package:app_features/app_features.dart';
import 'package:example/features/auth/auth_feature.dart';
import 'package:example/features/home/home_feature.dart';
import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.lock_outline,
                  size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 24),
              Text('Welcome Back',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  AuthService.login();
                  // Emit global event — listeners on Explore tab will receive it
                  AppFeatures.emit('user_logged_in', data: 'User123');
                  AppFeatures.get<HomeFeature>().go();
                  AppFeatures.scaffoldMessenger
                      .showSuccessMessage('Logged in successfully');
                },
                icon: const Icon(Icons.login),
                label: const Text('Login'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to nested sub-feature
                  AppFeatures.get<RegisterFeature>().push();
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Register (Nested Feature)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
