// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/RegisterLoginPage/login_page.dart';
import 'package:alchemiststock/services/_mainNavigationPage.dart';
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectlocationPage extends StatefulWidget {
  const SelectlocationPage({super.key});

  @override
  State<SelectlocationPage> createState() => SelectlocationPageState();
}

class SelectlocationPageState extends State<SelectlocationPage> {
  // VALUE ZONE & AREA
  String selectedZone = "";
  String selectedArea = "";

  // DATA ZONE DAN AREA (TERHUBUNG)
  final Map<String, List<String>> zoneAreaMap = {
    "Jawa": ["Jakarta", "Bandung", "Surabaya", "Semarang", "Jogja"],
    "Sumatera": ["Medan", "Padang", "Pekanbaru", "Aceh"],
    "Kalimantan": ["Pontianak", "Balikpapan", "Samarinda"],
    "Sulawesi": ["Makassar", "Manado", "Palu"],
    "Papua": ["Jayapura", "Merauke"],
    "Bali": ["Denpasar", "Tabanan", "Kuta"],
    "NTT/NTB": ["Kupang", "Mataram", "Bima"],
  };

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final prefs = await SharedPreferences.getInstance();

    final savedZone = prefs.getString("user_zone");
    final savedArea = prefs.getString("user_area");

    // Jika user sudah login + sudah simpan lokasi → langsung ke Home
    if (user != null && savedZone != null && savedArea != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationPage()),
      );
    }
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

  // =============================
  // BUTTON SUBMIT + VALIDASI + SAVE LOCAL
  // =============================
  ElevatedButton _buttonSubmit(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (selectedZone.isEmpty || selectedArea.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Isi Zone dan Area terlebih dahulu")),
          );
          return;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_zone", selectedZone);
        await prefs.setString("user_area", selectedArea);

        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // User sudah login → langsung ke Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainNavigationPage()),
          );
        } else {
          // User belum login → ke LoginPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        }
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

  // =============================
  // INPUT AREA (DEPENDENT)
  // =============================
  Widget _inputYourArea() {
    return GestureDetector(
      onTap: () {
        if (selectedZone.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Pilih Zone terlebih dahulu"),
              duration: Duration(seconds: 1),
            ),
          );
          return;
        }

        final items = zoneAreaMap[selectedZone] ?? [];
        _showDropdown(items, true);
      },
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(text: selectedArea),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 12),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 12),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xFF7C7C7C),
                size: 24,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            hintText: selectedZone.isEmpty
                ? "Select zone first"
                : "Types of your area",
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE2E2E2)),
            ),
          ),
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

  // =============================
  // INPUT ZONE
  // =============================
  Widget _inputYourZone() {
    return GestureDetector(
      onTap: () => _showDropdown(zoneAreaMap.keys.toList(), false),
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(text: selectedZone),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 12),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 12),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xFF7C7C7C),
                size: 24,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            hintText: "Types of your zone",
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE2E2E2)),
            ),
          ),
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

  // =============================
  // BACK BUTTON
  // =============================
  GestureDetector _backArrow(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
    );
  }

  // =============================
  // MAP
  // =============================
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

  // =============================
  // DROPDOWN BOTTOM SHEET
  // =============================
  void _showDropdown(List<String> items, bool isArea) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SizedBox(
          height: 350,
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  setState(() {
                    if (isArea) {
                      selectedArea = items[index];
                    } else {
                      selectedZone = items[index];
                      selectedArea = ""; // reset jika zone berubah
                    }
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
