// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  @override
  _PromoBannerState createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> bannerImages = [
    "assets/images/promo1.png",
    "assets/images/promo2.png",
    "assets/images/promo3.png",
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < bannerImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 368,
      height: 114,
      child: Stack(
        children: [
          // ===========================
          //   Background Carousel
          // ===========================
          PageView.builder(
            controller: _pageController,
            itemCount: bannerImages.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  bannerImages[index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              );
            },
          ),

          // ===========================
          //   Indicator Inside Banner
          // ===========================
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(bannerImages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == index ? 14 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
