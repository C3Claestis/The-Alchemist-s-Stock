import 'package:alchemiststock/page/RegisterLoginPage/signup_page.dart';
import 'package:alchemiststock/widget/template_sigin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

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

  Row _signUp(BuildContext context) {
    return Row(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupPage()),
                    ); // aksi klik
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _forgotPas() {
    return Row(
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
  }

  TextField _pasInput() {
    return TextField(
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

  TextField _emailInput() {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 12),

        hintText: "Types of your email",
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

  Text _descTxt() {
    return Text(
      "Enter your email and password",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _loginTxt() {
    return Text(
      'Login',
      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
    );
  }

  Padding _logoIcon() {
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

  ElevatedButton _btnSubmit(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
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
}
