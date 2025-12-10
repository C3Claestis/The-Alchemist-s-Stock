import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // SIMULASI login manual (contoh tanpa backend / Firebase)
  Future<bool> loginWithEmail(String email, String password) async {
    // Contoh validasi sederhana
    if (email == "admin@mail.com" && password == "123456") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_logged_in", true);
      await prefs.setString("user_email", email);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_logged_in") ?? false;
  }
}
