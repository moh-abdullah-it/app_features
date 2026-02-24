import 'package:app_features/app_features.dart';
import 'package:example/features/auth/auth_feature.dart';
import 'package:example/features/home/home_feature.dart';
import 'package:example/features/settings/settings_feature.dart';
import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader('Navigation'),
          _ActionTile(
            icon: Icons.settings,
            title: 'Settings (Feature Guard)',
            subtitle: 'Protected by redirect — requires login',
            onTap: () => AppFeatures.get<SettingsFeature>().push(),
          ),
          _ActionTile(
            icon: Icons.login,
            title: 'Auth Page',
            subtitle: 'push() — named navigation',
            onTap: () => AppFeatures.get<AuthFeature>().push(),
          ),
          _ActionTile(
            icon: Icons.person_add,
            title: 'Register (Nested Feature)',
            subtitle: 'AppFeatures.get<RegisterFeature>().push()',
            onTap: () => AppFeatures.get<RegisterFeature>().push(),
          ),
          _ActionTile(
            icon: Icons.route,
            title: 'Go to Auth by Path',
            subtitle: 'pushPath(\'/auth\') — path-based navigation',
            onTap: () => AppFeatures.get<AuthFeature>().pushPath('/auth'),
          ),
          _ActionTile(
            icon: Icons.refresh,
            title: 'Restart App',
            subtitle: 'AppFeatures.restart() — go to initial route',
            onTap: () => AppFeatures.restart(),
          ),
          const Divider(height: 32),
          const _SectionHeader('Dialog & Bottom Sheet Routes'),
          _ActionTile(
            icon: Icons.open_in_new,
            title: 'Dialog Route',
            subtitle: 'DialogPage via pageBuilder',
            onTap: () => AppFeatures.get<HomeFeature>().openDialog(),
          ),
          _ActionTile(
            icon: Icons.vertical_align_bottom,
            title: 'Bottom Sheet Route',
            subtitle: 'BottomSheetPage via pageBuilder',
            onTap: () => AppFeatures.get<HomeFeature>().openBottomSheet(),
          ),
          const Divider(height: 32),
          const _SectionHeader('Overlay Utilities'),
          _ActionTile(
            icon: Icons.hourglass_bottom,
            title: 'Show Loading',
            subtitle: 'AppFeatures.overlay.showLoading()',
            onTap: () {
              AppFeatures.overlay.showLoading();
              Future.delayed(
                  const Duration(seconds: 2), () => AppFeatures.pop());
            },
          ),
          _ActionTile(
            icon: Icons.chat_bubble_outline,
            title: 'Overlay Dialog',
            subtitle: 'AppFeatures.overlay.openDialog()',
            onTap: () => AppFeatures.overlay.openDialog(
              AlertDialog(
                title: const Text('Overlay Dialog'),
                content: const Text('Opened via AppFeatures.overlay'),
                actions: [
                  TextButton(
                    onPressed: () => AppFeatures.pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 32),
          const _SectionHeader('Scaffold Messenger'),
          _ActionTile(
            icon: Icons.check_circle_outline,
            title: 'Success Message',
            subtitle: 'scaffoldMessenger.showSuccessMessage()',
            onTap: () => AppFeatures.scaffoldMessenger
                .showSuccessMessage('Operation succeeded!'),
          ),
          _ActionTile(
            icon: Icons.error_outline,
            title: 'Error Message',
            subtitle: 'scaffoldMessenger.showErrorMessage()',
            onTap: () => AppFeatures.scaffoldMessenger
                .showErrorMessage('Something went wrong!'),
          ),
          _ActionTile(
            icon: Icons.info_outline,
            title: 'Toast Message',
            subtitle: 'scaffoldMessenger.showToast()',
            onTap: () =>
                AppFeatures.scaffoldMessenger.showToast('Quick toast'),
          ),
          const Divider(height: 32),
          const _SectionHeader('Global Event Bus'),
          _ActionTile(
            icon: Icons.send,
            title: 'Emit Event',
            subtitle: 'AppFeatures.emit(\'user_action\') — see Explore tab',
            onTap: () {
              AppFeatures.emit('user_action',
                  data: 'Button pressed from Home');
              AppFeatures.scaffoldMessenger
                  .showToast('Event emitted — check Explore tab');
            },
          ),
          _ActionTile(
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Emits user_logged_out event',
            onTap: () {
              AuthService.logout();
              AppFeatures.emit('user_logged_out');
              AppFeatures.scaffoldMessenger.showSuccessMessage('Logged out');
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle:
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
