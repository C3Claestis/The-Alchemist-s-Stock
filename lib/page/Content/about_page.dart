// ignore_for_file: deprecated_member_use, avoid_print
import 'package:alchemiststock/widget/widget_template_sigin.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Fungsi untuk membuka URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Bisa ditambahkan notifikasi jika gagal membuka URL
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateSigin(
      child: Column(
        children: [
          const Gap(30),
          _header(context),
          const Gap(24),
          _imageApp(),
          const Gap(16),
          _nameApp(),
          const Gap(4),
          _versionApp(),
          const Gap(24),
          _descriptionApp(),
          const Gap(32),
          _contactMe(),
          const Gap(12),
          SizedBox(
            width: 144,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ganti 'YOUR_DISCORD_INVITE_OR_PROFILE_URL' dengan URL Discord Anda
                IconButton(
                  onPressed: () =>
                      _launchURL('https://discord.com/users/mjs5293'),
                  icon: const Icon(
                    Icons.discord,
                    size: 32,
                    color: Color(0xFF5F33E1),
                  ),
                ),
                // Membuka WhatsApp ke nomor yang diberikan
                IconButton(
                  onPressed: () => _launchURL('https://wa.me/628812553446'),
                  icon: Image.asset(
                    'assets/images/WhatsApp.png',
                    height: 32,
                    width: 32,
                  ),
                ),
                // Ganti 'your_instagram_username' dengan username Instagram Anda
                IconButton(
                  onPressed: () =>
                      _launchURL('https://www.instagram.com/mjsidiq'),
                  icon: Image.asset(
                    'assets/images/Instagram.png',
                    height: 32,
                    width: 32,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(), // Mendorong widget di bawahnya ke bagian bawah
          _footer(),
          const Gap(16), // Memberi sedikit jarak dari bagian bawah layar
        ],
      ),
    );
  }

  CircleAvatar _imageApp() {
    return CircleAvatar(
      radius: 54,
      backgroundImage: const AssetImage('assets/images/Chisa.jpeg'),
    );
  }

  Text _nameApp() {
    return Text(
      "The Alchemist's Stock",
      style: GoogleFonts.lexendDeca(fontSize: 26, fontWeight: FontWeight.bold),
    );
  }

  Text _versionApp() {
    return Text(
      'Version 1.0.0',
      style: GoogleFonts.lexendDeca(fontSize: 12, color: Colors.grey.shade600),
    );
  }

  Padding _descriptionApp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        'The Alchemist’s Stock is designed to help you manage and organize magical ingredients, potions, and arcane supplies with ease. With a clean yet mystical interface, navigating your alchemist shop feels simple and efficient—allowing you to focus on crafting, brewing, and mastering the art of alchemy.',
        textAlign: TextAlign.center,
        style: GoogleFonts.lexendDeca(
          fontSize: 14,
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }

  Text _contactMe() {
    return Text(
      'Connect with me',
      style: GoogleFonts.lexendDeca(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Text _footer() {
    return Text(
      'Desain from Figma Community and Image From Wuthering Waves',
      style: GoogleFonts.lexendDeca(
        fontSize: 11,
        color: Colors.grey.shade500,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Padding _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, left: 22, right: 22),
      child: SizedBox(
        width: 331,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            ),
            Text(
              'About',
              style: GoogleFonts.lexendDeca(
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
