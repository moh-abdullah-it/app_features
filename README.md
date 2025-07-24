# App Features

A Flutter package that helps you organize your application structure by feature scope, with integrated routing, navigation, and UI utilities.

[![pub package](https://img.shields.io/pub/v/app_features.svg)](https://pub.dev/packages/app_features)

## Overview

App Features provides a structured way to organize your Flutter application by features, with each feature having its own routes, dependencies, and navigation capabilities. Built on top of [go_router](https://pub.dev/packages/go_router), it offers a clean architecture approach with additional utilities for common UI patterns.

## Features

- **Feature-based Architecture**: Organize your code by features, each with its own routes and dependencies
- **Integrated Routing**: Built on go_router with simplified navigation between features
- **Master Layout Support**: Create shell routes with bottom navigation for main app sections
- **Dialog & Bottom Sheet Routing**: Handle dialogs and bottom sheets as part of your navigation system
- **Overlay Support**: Show dialogs, bottom sheets, and loading indicators from anywhere
- **Scaffold Messenger Utilities**: Display snackbars and toast messages easily
- **Event System**: Subscribe to route changes and other events within features

## Installation

Add app_features to your pubspec.yaml:

```yaml
dependencies:
  app_features: ^1.0.1
```

Then run:

```bash
flutter pub get
```

## Basic Setup

### Configure App Features

In your main.dart file:

```dart
void main() {
  // Configure App Features with your features
  AppFeatures.config(
    features: [
      SplashFeature(),
      AuthFeature(),
      HomeFeature(),
    ],
    // Optional: Add a master layout for bottom navigation
    masterLayout: AppMasterLayout(),
    // Optional: Set initial route
    initLocation: '/',
  );

  runApp(const MyApp());
}
```

### Set Up MaterialApp

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Features Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Use AppFeatures router for navigation
      routerConfig: AppFeatures.router,
    );
  }
}
```

## Creating Features

### Basic Feature

Create a new feature by extending the `Feature` class:

```dart
import 'package:app_features/app_features.dart';

class AuthFeature extends Feature {
  @override
  String get name => '/auth';

  @override
  List<GoRoute> get routes => [
    GoRoute(
      path: name,
      name: name,
      builder: (_, __) => const AuthPage(),
    ),
    GoRoute(
      path: '$name/login',
      name: 'login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: '$name/register',
      name: 'register',
      builder: (_, __) => const RegisterPage(),
    ),
  ];

  // Optional: Define dependencies for this feature
  @override
  void get dependencies => () {
    // Initialize services, repositories, etc.
  };
}
```

### Feature with Dialog

You can create routes for dialogs:

```dart
GoRoute(
  path: '$name/confirm',
  name: 'confirm_dialog',
  pageBuilder: (context, state) => DialogPage(
    page: ConfirmDialog(
      message: state.extra as String,
    ),
  ),
),
```

### Feature with Bottom Sheet

Similarly for bottom sheets:

```dart
GoRoute(
  path: '$name/options',
  name: 'options_sheet',
  pageBuilder: (context, state) => BottomSheetPage(
    page: OptionsBottomSheet(),
    isScrollControlled: true,
    showDragHandle: true,
  ),
),
```

## Navigation

### Navigate to Features

```dart
// Push to a feature
AppFeatures.get<AuthFeature>().push();

// Go to a feature (clearing the stack)
AppFeatures.get<HomeFeature>().go();

// Replace current route with a feature
AppFeatures.get<ProfileFeature>().replace();

// Push and replace current route
AppFeatures.get<SettingsFeature>().pushReplacement();
```

### Navigate to Specific Routes

```dart
// Navigate to a specific route within a feature
AppFeatures.get<AuthFeature>().push(name: 'login');

// With parameters
AppFeatures.get<ProductFeature>().push(
  name: 'product_details',
  pathParameters: {'id': '123'},
  queryParameters: {'source': 'search'},
  extra: productData,
);
```

### Basic Navigation

```dart
// Go back
AppFeatures.pop();

// Check if can go back
if (AppFeatures.canPop()) {
  // Do something
}

// Refresh current route
AppFeatures.refresh;

// Restart app (go to initial route)
AppFeatures.restart();
```

## Master Layout

Create a master layout for bottom navigation:

```dart
class AppMasterLayout extends MasterLayout {
  @override
  List<Feature> get features => [
    HomeFeature(),
    ExploreFeature(),
    ProfileFeature(),
  ];

  @override
  BottomNavigationBuilder get bottomNavigationBar =>
    (navigationShell) => BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: navigationShell.goBranch,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
}
```

## Utilities

### Overlay Utilities

```dart
// Show a dialog
AppFeatures.overlay.openDialog(
  MyCustomDialog(data: someData),
);

// Show a bottom sheet
AppFeatures.overlay.openModalBottomSheet(
  MyBottomSheet(),
  isScrollControlled: true,
  showDragHandle: true,
);

// Show a loading indicator
AppFeatures.overlay.showLoading();
```

### Scaffold Messenger Utilities

```dart
// Show a success message
AppFeatures.scaffoldMessenger.showSuccessMessage('Profile updated successfully');

// Show an error message
AppFeatures.scaffoldMessenger.showErrorMessage('Failed to update profile');

// Show a toast message
AppFeatures.scaffoldMessenger.showToast('Processing...');

// Show a custom snackbar
AppFeatures.scaffoldMessenger.showSnackBar(
  content: Text('Custom message'),
  backgroundColor: Colors.purple,
);
```

## Event System

Subscribe to route changes within a feature:

```dart
@override
listen() {
  on('product_details', (pathParams, queryParams, extra) {
    // Do something when navigating to product_details
    final productId = pathParams?['id'];
    loadProductData(productId);
  });
}
```

## Advanced Usage

### Custom Master Page Builder

```dart
class AppMasterLayout extends MasterLayout {
  @override
  List<Feature> get features => [
    HomeFeature(),
    ProfileFeature(),
  ];

  @override
  StatefulShellRouteBuilder get masterPageBuilder =>
    (context, state, navigationShell) {
      return CustomMasterPage(
        navigationShell: navigationShell,
        // Custom properties
      );
    };
}
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
