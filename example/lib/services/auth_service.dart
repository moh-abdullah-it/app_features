/// Simple auth service for demo purposes
class AuthService {
  static bool isLoggedIn = false;

  static void login() => isLoggedIn = true;
  static void logout() => isLoggedIn = false;
}
