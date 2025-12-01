// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class TemplateSigin extends StatelessWidget {
  final Widget child;

  const TemplateSigin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image Atas
          _bgAtas(),
          // BACKGROUND BAWAH
          _bgBawah(),

          if (child != null) child,
        ],
      ),
    );
  }

  Align _bgBawah() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgblurbottom.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Container _bgAtas() {
    return Container(
      height: 233,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bgblurtop.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
