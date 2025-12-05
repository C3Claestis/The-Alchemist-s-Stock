import 'package:alchemiststock/page/RegisterLoginPage/login_page.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectlocationPage extends StatefulWidget {
  const SelectlocationPage({super.key});

  @override
  State<SelectlocationPage> createState() => SelectlocationPageState();
}

class SelectlocationPageState extends State<SelectlocationPage> {
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
                _backArrow(context),
                const Gap(44),
                _map(),
                const Gap(120),
                _yourZoneTxt(),
                const Gap(8),
                _inputYourZone(),
                const Gap(30),
                _yourAreaTxt(),
                const Gap(8),
                _inputYourArea(),
                const Gap(30),
                _buttonSubmit(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buttonSubmit(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
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
        'Submit',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextField _inputYourArea() {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 12),

        // ICON DI KANAN
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Color(0xFF7C7C7C),
            size: 24,
          ),
        ),

        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

        hintText: "Types of your area",
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),

        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  Text _yourAreaTxt() {
    return Text(
      "Your Area",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TextField _inputYourZone() {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(bottom: 12),

        // ICON DI KANAN
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Color(0xFF7C7C7C),
            size: 24,
          ),
        ),

        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

        hintText: "Types of your zone",
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),

        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2E2)),
        ),
      ),
    );
  }

  Text _yourZoneTxt() {
    return Text(
      "Your Zone",
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  GestureDetector _backArrow(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
    );
  }

  SizedBox _map() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Image.asset('assets/images/mapIlus.png', scale: 2),
          const Gap(42),
          const Text(
            "Select Your Location",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Gap(8),
          Text(
            "Switch on your location to stay in tune with\nwhat's happening in your area",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
