import 'package:alchemiststock/widget/widget_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(),
          Divider(height: 1),
          const Gap(10),
          Column(
            children: [
              AccountProduct(path: "orders", name: "Orders"),
              AccountProduct(path: "mydetail", name: "My Details"),
              AccountProduct(path: "pointermap", name: "Delivery Address"),
              AccountProduct(path: "paymethod", name: "Payment Methods"),
              AccountProduct(path: "promocard", name: "Promo Card"),
              AccountProduct(path: "notif", name: "Notifications"),
              AccountProduct(path: "help", name: "Help & Support"),
              AccountProduct(path: "about", name: "About"),
            ],
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
            backgroundImage: AssetImage('assets/images/Chisa.jpeg'),
          ),
          const Gap(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Chisasa',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: GestureDetector(
                        onTap: () {
                          // aksi klik
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 6, bottom: 8),
                          child: SvgPicture.asset(
                            'assets/svgs/edit.svg',
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
                'chisa1211@gmail.com',
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
