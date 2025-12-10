// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/RegisterLoginPage/signup_page.dart';
import 'package:alchemiststock/services/_mainNavigationPage.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  Future<void> loginUser() async {
    try {
      // 1. Login ke Firebase
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = credential.user;

      // 2. Cek apakah email sudah diverifikasi
      if (user != null && !user.emailVerified) {
        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please verify your email before logging in."),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // 3. Jika sudah diverifikasi → masuk ke aplikasi
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'user-not-found') {
        message = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else {
        message = e.message ?? "Login failed";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
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
                _logoIcon(),
                const Gap(100),
                _loginTxt(),
                const Gap(8),
                _descTxt(),
                const Gap(40),
                _emailTxt(),
                const Gap(12),
                _emailInput(),
                const Gap(30),
                _pasTxt(),
                const Gap(12),
                _pasInput(),
                _forgotPas(),
                const Gap(8),
                _btnSubmit(context),
                const Gap(20),
                _signUp(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =================== CONTROLLER WIDGETS ===================

  TextField _emailInput() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(bottom: 12),
        hintText: "Types of your email",
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  TextField _pasInput() {
    return TextField(
      controller: _passwordController,
      obscureText: _isObscure,
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
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() => _isObscure = !_isObscure);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF7C7C7C),
              size: 24,
            ),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  ElevatedButton _btnSubmit(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await loginUser(); // 🔥 proses login Firebase
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF53B175),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        minimumSize: const Size(353, 67),
      ),
      child: Text(
        'Log In',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // UI helper tidak saya ubah
  Text _loginTxt() => Text(
        'Login',
        style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
      );
  Text _descTxt() => Text(
        "Enter your email and password",
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      );
  Text _emailTxt() => Text(
        "Email",
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      );
  Text _pasTxt() => Text(
        "Password",
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      );
  Row _forgotPas() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
      );
  Row _signUp(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: "Sign Up",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF53B175),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const SignupPage()));
                    },
                ),
              ],
            ),
          ),
        ],
      );
  Padding _logoIcon() => Padding(
        padding: const EdgeInsets.only(top: 98),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Witch_Hat.png', color: Colors.brown),
          ],
        ),
      );
}
