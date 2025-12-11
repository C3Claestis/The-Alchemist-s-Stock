// ignore_for_file: use_build_context_synchronously

import 'package:alchemiststock/page/Content/about_page.dart';
import 'package:alchemiststock/page/RegisterLoginPage/signin_page.dart';
import 'package:alchemiststock/widget/widget_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userName = "";
  String userEmail = "";
  String userPhoto = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  bool _isGoogleUser() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    // cek provider login-nya
    for (var info in user.providerData) {
      if (info.providerId == "google.com" && info.photoURL != null) {
        return true; // pengguna login Google
      }
    }
    return false; // login email biasa
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    setState(() {
      if (user != null) {
        // Ambil dari Firebase user langsung
        userName =
            user.displayName ?? prefs.getString("user_name") ?? "Guest User";
        userEmail = user.email ?? prefs.getString("user_email") ?? "No email";
        userPhoto = user.photoURL ?? prefs.getString("user_photo") ?? "";
      } else {
        // fallback kalau tidak ada user login
        userName = prefs.getString("user_name") ?? "Guest User";
        userEmail = prefs.getString("user_email") ?? "No email";
        userPhoto = prefs.getString("user_photo") ?? "";
      }
    });
  }

  Future<void> logoutGoogle() async {
    await GoogleSignIn().signOut(); // Logout dari Google
    await FirebaseAuth.instance.signOut(); // Logout Firebase
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: [
                AccountProduct(path: "orders", name: "Orders", onTap: null),
                AccountProduct(
                  path: "mydetail",
                  name: "My Details",
                  onTap: null,
                ),
                AccountProduct(
                  path: "pointermap",
                  name: "Delivery Address",
                  onTap: null,
                ),
                AccountProduct(
                  path: "paymethod",
                  name: "Payment Methods",
                  onTap: null,
                ),
                AccountProduct(
                  path: "promocard",
                  name: "Promo Card",
                  onTap: null,
                ),
                AccountProduct(
                  path: "notif",
                  name: "Notifications",
                  onTap: null,
                ),
                AccountProduct(
                  path: "help",
                  name: "Help & Support",
                  onTap: null,
                ),
                AccountProduct(
                  path: "about",
                  name: "About",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutPage()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _header() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20, bottom: 30),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 32,
            backgroundImage: _isGoogleUser()
                ? NetworkImage(userPhoto)
                : const AssetImage('assets/images/Chisa.jpeg'),          ),
          const Gap(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: userName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: GestureDetector(
                        onTap: () async {
                          await logoutGoogle(); // panggil logout

                          // setelah logout, arahkan ke SigninPage
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => SigninPage()),
                            (route) => false,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, bottom: 8),
                          child: SvgPicture.asset(
                            'assets/svgs/edit.svg',
                            // ignore: deprecated_member_use
                            color: Colors.red,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                userEmail,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
