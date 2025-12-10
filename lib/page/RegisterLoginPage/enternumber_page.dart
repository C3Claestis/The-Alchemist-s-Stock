// ignore_for_file: avoid_print
import 'package:alchemiststock/page/RegisterLoginPage/verifnumber_page.dart';
import 'package:alchemiststock/services/_PhoneController.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:alchemiststock/services/_authController.dart';

class EnternumberPage extends StatefulWidget {
  final PhoneController controller;

  const EnternumberPage({super.key, required this.controller});

  @override
  State<EnternumberPage> createState() => _EnternumberPageState();
}

class _EnternumberPageState extends State<EnternumberPage> {
  late PhoneController phoneCtrl;
  String _completePhoneNumber = '';

  @override
  void initState() {
    super.initState();

    phoneCtrl = widget.controller;

    phoneCtrl.onNumberChanged = (value) {
      print("Nomor berubah: $value");
    };
  }

  @override
  Widget build(BuildContext context) {
    return TemplateSigin(
      child: Stack(
        children: [
          Positioned(
            top: 64,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backBtn(context),
                const Gap(64),
                _headerTxt(),
                const Gap(26),
                _instructionTxt(),
                const Gap(10),

                IntlPhoneField(
                  controller: widget.controller.numberController,
                  initialCountryCode: 'ID',
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                    ),
                  ),
                  onChanged: (phone) {
                    // Simpan nomor lengkap dengan kode negara
                    _completePhoneNumber = phone.completeNumber;
                  },
                ),

                /// ====================
              ],
            ),
          ),

          _nextBtn(context),
        ],
      ),
    );
  }

  Positioned _nextBtn(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      right: 24,
      child: ElevatedButton(
        onPressed: () {
          if (_completePhoneNumber.isEmpty || widget.controller.numberController.text.trim().isEmpty) {
            print("Nomor tidak boleh kosong");
            return;
          }
          AuthController.sendOtp(
            phoneNumber: _completePhoneNumber,
            onCodeSent: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VerifnumberPage(phoneNumber: _completePhoneNumber),
                ),
              );
            },
            onError: (msg) {
              // Tampilkan pesan error kepada pengguna
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to send OTP: $msg'),
                  backgroundColor: Colors.red,
                ),
              );
              print("ERROR: $msg"); // Tetap log untuk debug
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
    );
  }

  Text _instructionTxt() => Text(
    "Mobile Number",
    style: GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
  );

  Text _headerTxt() {
    return const Text(
      "Enter your mobile number",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  GestureDetector _backBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
    );
  }
}
