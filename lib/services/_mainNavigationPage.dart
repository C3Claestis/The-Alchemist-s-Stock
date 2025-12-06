// ignore_for_file: file_names

import 'package:alchemiststock/model/category.dart';
import 'package:alchemiststock/page/main/account_page.dart';
import 'package:alchemiststock/page/main/cart_page.dart';
import 'package:alchemiststock/page/main/favourite_page.dart';
import 'package:alchemiststock/page/main/findproduct_page.dart';
import 'package:alchemiststock/page/main/homescreen_page.dart';
import 'package:alchemiststock/services/_category_service.dart';
import 'package:flutter/material.dart';
import 'package:alchemiststock/widget/widget_bottomNavbar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(currentIndex),
      bottomNavigationBar: NavBar(currentIndex: currentIndex, onTap: onTap),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomescreenPage();
      case 1:
        return FutureBuilder<List<CategoryModel>>(
          future: CategoryService().getCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return FindproductPage(categories: snapshot.data!);
          },
        );
      case 2:
        return const CartPage();
      case 3:
        return const FavouritePage();
      case 4:
        return const AccountPage();
      default:
        return const HomescreenPage();
    }
  }
}
