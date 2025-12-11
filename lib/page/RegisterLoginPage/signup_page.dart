// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/RegisterLoginPage/login_page.dart';
import 'package:alchemiststock/page/RegisterLoginPage/privacyPolicy_page.dart';
import 'package:alchemiststock/page/RegisterLoginPage/termservice_page.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  bool _isEmailValid = false;

  bool validateEmail(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  Future<void> registerUser() async {
    try {
      // 1. Daftar user ke Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      User? user = userCredential.user;

      // 2. Kirim email verifikasi
      await user?.sendEmailVerification();

      // 3. Simpan username ke displayName
      await user?.updateDisplayName(_usernameController.text);

      // 4. Simpan data ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_name", _usernameController.text.trim());
      await prefs.setString("user_email", _emailController.text.trim());
      await prefs.setString(
        "user_photo",
        "",
      ); // tidak ada foto untuk signup biasa

      showSuccessPopup(); // tampilkan popup sukses
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'email-already-in-use') {
        message = "This email is already registered.";
      } else if (e.code == 'weak-password') {
        message = "Password must be at least 6 characters.";
      } else {
        message = e.message ?? "Sign Up failed, try again.";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isAllValid() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.length >= 6 &&
        _isEmailValid;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateSigin(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _icon(),
                const Gap(100),
                _signUpTxt(),
                const Gap(8),
                _descTxt(),
                const Gap(40),
                _usernameTxt(),
                const Gap(12),
                _inputUsername(),
                const Gap(30),
                _emailTxt(),
                const Gap(12),
                _inputEmail(),
                const Gap(30),
                _pasTxt(),
                const Gap(12),
                _inputPas(),
                const Gap(8),
                _termPolicyTxt(context),
                const Gap(20),
                _btnSignup(context),
                const Gap(20),
                _goSignIn(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _btnSignup(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (isAllValid()) {
          await registerUser(); // panggil Firebase Sign Up
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please complete all fields correctly"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Text(
        'Sign Up',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Row _goSignIn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: "Already have an account? ",
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: "Sign In",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF53B175),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    ); // aksi klik
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  RichText _termPolicyTxt(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "By continuing you agree to our ",
        style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 14),
        children: [
          TextSpan(
            text: "Term of Service",
            style: GoogleFonts.poppins(
              color: const Color(0xFF53B175),
              fontSize: 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermservicePage()),
                ); // aksi klik
              },
          ),
          TextSpan(
            text: "\nand",
            style: GoogleFonts.poppins(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: " Privacy Policy.",
            style: GoogleFonts.poppins(
              color: const Color(0xFF53B175),
              fontSize: 14,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacypolicyPage()),
                ); // aksi klik
              },
          ),
        ],
      ),
    );
  }

  TextField _inputEmail() {
    return TextField(
      controller: _emailController,
      onChanged: (value) {
        setState(() {
          _isEmailValid = validateEmail(value); // cek valid atau tidak
        });
      },
      inputFormatters: [LengthLimitingTextInputFormatter(32)],
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(bottom: 12),

        hintText: "Types of your email",
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),

        // ==========================
        //  ICON BERUBAH
        // ==========================
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Icon(
            _isEmailValid ? Icons.check_circle : Icons.cancel,
            color: _isEmailValid ? Colors.green : Colors.red,
            size: 22,
          ),
        ),

        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  TextField _inputPas() {
    return TextField(
      controller: _passwordController,
      obscureText: _isObscure, // switch tampil / tidak
      inputFormatters: [LengthLimitingTextInputFormatter(16)],
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(bottom: 12),

        hintText: "Types of your password",
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),

        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),

        // =======================
        //  TOGGLE EYE ICON
        // =======================
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscure = !_isObscure; // toggle true/false
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Icon(
              _isObscure
                  ? Icons
                        .visibility_off // saat sembunyi
                  : Icons.visibility, // saat terlihat
              color: const Color(0xFF7C7C7C),
              size: 24,
            ),
          ),
        ),

        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  Text _pasTxt() {
    return Text(
      "Password",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _emailTxt() {
    return Text(
      "Email",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TextField _inputUsername() {
    return TextField(
      controller: _usernameController,
      inputFormatters: [LengthLimitingTextInputFormatter(16)],
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 12),

        hintText: "Types of your username",
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),

        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  Text _usernameTxt() {
    return Text(
      "Username",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _descTxt() {
    return Text(
      "Enter your credentials to continue",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _signUpTxt() {
    return Text(
      'Sign Up',
      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
    );
  }

  Padding _icon() {
    return Padding(
      padding: const EdgeInsets.only(top: 98),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Witch_Hat.png', color: Colors.brown),
        ],
      ),
    );
  }

  void showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // tidak bisa di-klik di luar
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                const SizedBox(height: 16),
                Text(
                  "Sign Up Successful!",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your account has been created.",
                  style: GoogleFonts.poppins(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // tutup dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF53B175),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Text(
                      "Go to Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
