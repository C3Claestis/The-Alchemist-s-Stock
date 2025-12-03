// ignore_for_file: file_names

import 'package:alchemiststock/page/main/account_page.dart';
import 'package:alchemiststock/page/main/cart_page.dart';
import 'package:alchemiststock/page/main/favourite_page.dart';
import 'package:alchemiststock/page/main/findproduct_page.dart';
import 'package:alchemiststock/page/main/homescreen_page.dart';
import 'package:flutter/material.dart';
import 'package:alchemiststock/widget/widget_bottomNavbar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomescreenPage(),
    const FindproductPage(),
    const CartPage(),
    const FavouritePage(),
    const AccountPage(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavBar(currentIndex: currentIndex, onTap: onTap),
    );
  }
}
