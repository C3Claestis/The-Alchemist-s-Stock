import 'package:alchemiststock/widget/widget_product_rare.dart';
import 'package:alchemiststock/widget/widget_product_sell.dart';
import 'package:alchemiststock/widget/widget_promo_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomescreenPage extends StatefulWidget {
  const HomescreenPage({super.key});

  @override
  State<HomescreenPage> createState() => _HomescreenPageState();
}

class _HomescreenPageState extends State<HomescreenPage> {
  String zone = 'Jawa Barat';
  String area = 'Bogor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _logoIcon(),
              const Gap(8),
              _locationHeader(),
              const Gap(18),
              _searchBar(),
              const Gap(20),
              PromoBanner(),
              const Gap(30),
              _contentTitleTxt("Exclusive Offer"),
              const Gap(20),
              _contentCard(),
              const Gap(30),
              _contentTitleTxt("Best Selling"),
              const Gap(20),
              _contentCard(),
              const Gap(30),
              _contentTitleTxt("Groceries"),
              const Gap(20),
              _contentCardRare(),
              const Gap(20),
              _contentCard(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _contentCardRare() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SizedBox(
        height: 105,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => ProductRare(),
          separatorBuilder: (context, index) => const Gap(14),
          itemCount: 3,
        ),
      ),
    );
  }

  Padding _contentCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: SizedBox(
        height: 248,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => ProductSell(),
          separatorBuilder: (context, index) => const Gap(14),
          itemCount: 3,
        ),
      ),
    );
  }

  Padding _contentTitleTxt(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'See all',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xFF53B175),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Container _searchBar() {
    return Container(
      width: 364,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search item...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _locationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svgs/pointermap.svg'),
        const Gap(8),
        Text(
          '$zone, $area',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Padding _logoIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Witch_Hat.png', color: Colors.brown),
        ],
      ),
    );
  }
}
