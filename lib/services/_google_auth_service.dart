// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthService {

  Future<User?> signInWithGoogle() async {
    try {
      // 1. Trigger Google Sign In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // batal login

      // 2. Ambil authentication
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Buat credential Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Login ke Firebase
      final userCredential = 
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  Future saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_name", user.displayName ?? "");
    prefs.setString("user_email", user.email ?? "");
    prefs.setString("user_photo", user.photoURL ?? "");
  }
}
