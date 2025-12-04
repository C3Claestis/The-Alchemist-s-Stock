// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:alchemiststock/page/RegisterLoginPage/verifnumber_page.dart';
import 'package:alchemiststock/services/_PhoneController.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EnternumberPage extends StatefulWidget {
  final PhoneController controller;

  const EnternumberPage({super.key, required this.controller});

  @override
  State<EnternumberPage> createState() => _EnternumberPageState();
}

class _EnternumberPageState extends State<EnternumberPage> {
  late PhoneController phoneCtrl;

  List<Map<String, dynamic>> countries = [];

  @override
  void initState() {
    super.initState();

    phoneCtrl = widget.controller;

    phoneCtrl.onNumberChanged = (value) {
      print("Nomor berubah: $value");
    };

    _loadCountriesJson();
  }

  Future<void> _loadCountriesJson() async {
    final String response = await rootBundle.loadString(
      'assets/data/countries.json',
    );
    final data = json.decode(response);

    setState(() {
      countries = List<Map<String, dynamic>>.from(data);
    });
  }

  // Default Indonesia
  String selectedFlag = "id";
  String selectedCode = "+62";

  void openCountryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        children: countries.map((c) {
          return ListTile(
            leading: SvgPicture.asset(
              "assets/svgs/flag/${c['code']}.svg",
              width: 28,
            ),
            title: Text(c["name"]),
            trailing: Text(c["dial_code"]),
            onTap: () {
              setState(() {
                selectedFlag = c["code"]; // perbaikan
                selectedCode = c["dial_code"]; // perbaikan
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

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
                _backBtn(context),
                const Gap(64),
                _headerTxt(),
                const Gap(26),
                _instructionTxt(),
                const Gap(10),
                TextField(
                  controller: widget.controller.numberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: GestureDetector(
                      onTap: openCountryPicker,
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.only(right: 8),                        // atau sesuai kebutuhan
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/flag/$selectedFlag.svg",
                              width: 24,
                            ),
                            const Gap(4),
                            Text(selectedCode, style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )),
                          ],
                        ),
                      ),
                    ),

                    prefixIconConstraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: 110,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2E2E2)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // BUTTON KANAN BAWAH
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

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VerifnumberPage()),
    );
  }
}
