import 'package:alchemiststock/widget/template_sigin.dart';
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
                Padding(
                  padding: const EdgeInsets.only(top: 72),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Witch_Hat.png',
                        color: Colors.brown,
                      ),
                    ],
                  ),
                ),
                const Gap(120),
                Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                Text(
                  "Enter your email and password",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(40),
                Text(
                  "Email",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(12),
                TextField(
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
                ),
                const Gap(30),
                Text(
                  "Password",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(12),
                TextField(
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

                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),

                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                    ),
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    TextButton(onPressed: () {}, child: Text('Forgot Password?'))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
