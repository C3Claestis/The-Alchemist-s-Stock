// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PhoneController {
  // Controller untuk textfield input nomor
  final TextEditingController numberController = TextEditingController();

  // Listener event
  void Function(String value)? onNumberChanged;

  PhoneController() {
    numberController.addListener(() {
      if (onNumberChanged != null) {
        onNumberChanged!(numberController.text);
      }
    });
  }

  void dispose() {
    numberController.dispose();
  }
}
