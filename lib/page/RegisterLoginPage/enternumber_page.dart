import 'package:alchemiststock/page/RegisterLoginPage/verifnumber_page.dart';
import 'package:alchemiststock/widget/template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EnternumberPage extends StatefulWidget {
  const EnternumberPage({super.key});

  @override
  State<EnternumberPage> createState() => _EnternumberPageState();
}

class _EnternumberPageState extends State<EnternumberPage> {
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
                  "Enter your mobile number",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                const Gap(26),

                Text("Mobile Number", style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),),
                const Gap(10),

                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.flag,
                        color: Color(0xFF7C7C7C),
                        size: 24,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 0),
                    labelText: "+62",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BUTTON KANAN BAWAH
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () {
                _goToNextPage();
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
          ),
        ],
      ),
    );
  }

  void _goToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const VerifnumberPage()),
    );
  }
}
