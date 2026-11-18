// Demo authentication used by the student application.
// All account data lives in memory only, so it is lost when the app restarts.
// The default account is admin / admin123 and always works.
class DemoAuth {
  // Username and password of the account created through RegisterScreen.
  static String? registeredUsername;
  static String? registeredPassword;

  // Username of the account that is currently logged in.
  static String? currentUsername;

  // Checks whether the supplied credentials match the default admin account
  // or the registered account. Returns true and stores currentUsername when
  // the credentials are valid, otherwise returns false.
  static bool login(String username, String password) {
    final isAdmin = username == 'admin' && password == 'admin123';

    final isRegisteredUser = registeredUsername != null &&
        username == registeredUsername &&
        password == registeredPassword;

    if (isAdmin || isRegisteredUser) {
      currentUsername = username;
      return true;
    }

    return false;
  }

  // Stores the registered username and password in memory. Registering again
  // replaces the previous account.
  static void register(String username, String password) {
    registeredUsername = username;
    registeredPassword = password;
  }

  // Logs the current user out by clearing currentUsername.
  static void logout() {
    currentUsername = null;
  }
}
