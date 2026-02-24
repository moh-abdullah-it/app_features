import 'package:app_features/app_features.dart';
import 'package:flutter/material.dart';

/// Demonstrates: global event bus listener
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> _events = [];

  @override
  void initState() {
    super.initState();
    // Subscribe to global events from other features
    AppFeatures.on('user_action', _onUserAction);
    AppFeatures.on('user_logged_in', _onUserLoggedIn);
    AppFeatures.on('user_logged_out', _onUserLoggedOut);
  }

  void _onUserAction(Object? data) {
    if (mounted) setState(() => _events.add('user_action: $data'));
  }

  void _onUserLoggedIn(Object? data) {
    if (mounted) setState(() => _events.add('user_logged_in: $data'));
  }

  void _onUserLoggedOut(Object? data) {
    if (mounted) setState(() => _events.add('user_logged_out'));
  }

  @override
  void dispose() {
    AppFeatures.off('user_action', _onUserAction);
    AppFeatures.off('user_logged_in', _onUserLoggedIn);
    AppFeatures.off('user_logged_out', _onUserLoggedOut);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => setState(() => _events.clear()),
            tooltip: 'Clear events',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Branch Config',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    const Text('preloadBranch: true'),
                    const Text('branchRestorationScopeId: explore_branch'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Global Event Bus',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _events.isEmpty
                ? const Center(
                    child: Text(
                      'No events received yet.\n'
                      'Go to Home tab and emit events.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _events.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.event_note),
                        title: Text(_events[index]),
                        trailing: Text('#${index + 1}'),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
