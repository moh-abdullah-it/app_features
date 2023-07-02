# Feature By Feature
 This package help you to Organize folders Structure by feature scope. **package in development**

## Features
1. Feature scope routes and dependents
2. Manage Routes by go_router
3. Handle dialog and bottom sheet by routes
4. Handle Snack Bar by ScaffoldMessenger
5. Overlay Support

## Getting started

* Install package:
``` shell
 flutter pub add app_features
```
* Config routes:
``` dart 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Features Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppFeatures.router,
    );
  }
}
```

## New Feature
to create new feature you need to:
* feature class 
* feature page as view

lets create login feature example:
1. create `login_page.dart` file as login view page.
2. create new class file name `login_feaure.dart`:
    ``` dart
    import 'package:app_features/app_features.dart';
    
    class LoginFeature extends Feature {
    
        @override
        String get name => '/login';
    
        @override
        List<GoRoute> get routes => [
             GoRoute(
              path: name,
              name: name,
              builder: (_, __) => const LoginPage(),
            )
        ]
    }
    ```
3. Register new feature to `AppFeatures` config:
``` dart 
void main() {
  AppFeatures.config(
    features: [
        SplashFeature(),
        LoginFeatue()
      ],
  );
  runApp(const MyApp());
}
```
