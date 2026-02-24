## 1.2.0
* Add **Feature Guards**: per-feature `redirect` method that runs before route-level redirects.
* Add **Async Initialization**: `Feature.init()` hook + `AppFeatures.configAsync()` for async setup.
* Add **Feature Middleware**: `onEnter`/`onLeave` lifecycle hooks triggered automatically on navigation.
* Add **Multi-Listener Events**: `Feature.on()` now supports multiple callbacks per route name + `off()`/`offAll()`.
* Add **Global Event Bus**: `AppFeatures.on()`/`emit()`/`off()` for cross-feature communication.
* Add **Nested Features**: `Feature.subFeatures` for automatic sub-feature registration.
* Rewrite example app to demonstrate all features: async init, feature guards, middleware, multi-listener events, global event bus, nested features, branch config, shell route config, dialog/bottom sheet routes, overlay utilities, scaffold messenger, and Material 3.

## 1.1.0
* **BREAKING**: upgrade `go_router` from `^16.0.0` to `^17.0.0`.
* **Bug Fix**: fix `routesWithRootKey` losing `onExit` and `caseSensitive` properties when rebuilding routes.
* **Bug Fix**: fix `refresh` getter executing once at init instead of on each call.
* **Bug Fix**: fix typo in error message ("Future" to "Feature").
* Expand `Feature.routes` from `List<GoRoute>` to `List<RouteBase>` to support `ShellRoute` and other route types.
* Add all `GoRouter` constructor parameters to `AppFeatures.config()` (`redirect`, `refreshListenable`, `onException`, `errorPageBuilder`, `errorBuilder`, `observers`, `debugLogDiagnostics`, `routerNeglect`, `overridePlatformDefaultLocation`, `initialExtra`, `redirectLimit`, `restorationScopeId`, `requestFocus`, `extraCodec`).
* Add path-based navigation methods on `Feature`: `pushPath`, `goPath`, `replacePath`, `pushReplacementPath`.
* Add `fragment` parameter to `Feature.go()`.
* Add static helpers on `AppFeatures`: `namedLocation`, `go`, `push`, `state`.
* Add branch config getters on `Feature`: `preloadBranch`, `branchInitialLocation`, `branchObservers`, `branchRestorationScopeId`.
* Add `MasterLayout` shell route config: `restorationScopeId`, `redirect`, `parentNavigatorKey`, `navigatorContainerBuilder`, `notifyRootObserver`.

## 1.0.2
* upgrade dependencies.
* Comprehensive documentation update with detailed examples and usage instructions.

## 1.0.1
* update go_router ^13.2.1.

## 1.0.0
* modify `restart` to restart app.

## 0.9.0
* modify `modifyListener` to master layout if use masterPageBuilder

## 0.8.0
* improve `listen` to feature route navigation
* modify `on` to register route event

## 0.7.0
* improve `pop` with result
* modify `canPop`

## 0.6.0
* modify `onNavigate` to listen if routes in feature changed
* modify `onBranchChange` to listen if branch in master layout changed
* upgrade `go_router` dependencies

## 0.5.0
* fix open page route form other branch

## 0.4.0
* Modify Route Out of Master Layout
* upgrade dependencies `go_router`

## 0.3.0
* modify options to `showLoading`
* modify readme docs

## 0.2.1
* Provide documentation public API dartdoc comments

## 0.2.0
* improve support `OverlayUtils`
* modify `AppFeatures.overlay` and `AppFeatures.scaffoldMessenger`
* remove static methods from `AppFeatures` dialog and other messages

## 0.1.1
* remove unused code

## 0.1.0
* modify support nested route navigation
* modify `MasterLayout`
* modify support bottom navigation bar

## 0.0.3
* modify `OverlayUtils`

## 0.0.2
* modify `showSnackBar` to `AppFeatures`

## 0.0.1
* first release.
