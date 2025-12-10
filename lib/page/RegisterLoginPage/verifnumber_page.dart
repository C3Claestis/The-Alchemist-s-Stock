// ignore_for_file: avoid_print

import 'package:alchemiststock/page/RegisterLoginPage/selectlocation_page.dart';
import 'package:alchemiststock/services/_OtpInputState.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alchemiststock/services/_authController.dart';

class VerifnumberPage extends StatefulWidget {
  final String phoneNumber;

  const VerifnumberPage({super.key, required this.phoneNumber});

  @override
  State<VerifnumberPage> createState() => _VerifnumberPageState();
}

class _VerifnumberPageState extends State<VerifnumberPage> {
  final GlobalKey<OtpInputState> _otpInputKey = GlobalKey<OtpInputState>();

  @override
  Widget build(BuildContext context) {
    return TemplateSigin(
      child: Stack(
        children: [
          // KONTEN UTAMA
          Positioned(
            top: 64,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  ),
                ),

                const Gap(64),

                const Text(
                  "Enter your 4-digit code",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                const Gap(26),

                Text(
                  "Code",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(10),

                OtpInput(key: _otpInputKey),
              ],
            ),
          ),

          // BUTTON KANAN BAWAH
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24, // ← penting! agar Row punya full width
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: const Text('Resend Code')),
                ElevatedButton(
                  onPressed: () async {
                    final code = _otpInputKey.currentState?.getOtp() ??
                        ""; // Ambil kode dari state

                    AuthController.verifyOtp(
                      code: code,
                      onSuccess: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SelectlocationPage(),
                          ),
                        );
                      },
                      onError: (msg) {
                        // Tampilkan pesan error kepada pengguna
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid OTP, please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF53B175),
                    shape: const CircleBorder(),
                    fixedSize: const Size(60, 60),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _goToNextPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => const SelectlocationPage()),
  //   );
  // }
}
