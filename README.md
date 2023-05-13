# Feature By Feature
 This package help you to Organize folders Structure by feature scope.
** package in development **

## Features
* Feature scope
* Routes by go_router
* Handle dialog and bottom sheet by routes
* Handle Snack Bar by ScaffoldMessenger

## Getting started

* Install package:
``` shell
 flutter pub add app_features
```
* Config `go_router`:
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
* Config `AppFeatures` by modify your features:
``` dart 
void main() {
  AppFeatures.config(
    features: [
        SplashFeature(),
        HomeFeature()
      ],
  ).init();
  runApp(const MyApp());
}
```
