// ignore_for_file: file_names, use_super_parameters

import 'package:flutter/material.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({Key? key}) : super(key: key);

  @override
  State<OtpInput> createState() => OtpInputState();
}

class OtpInputState extends State<OtpInput> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: "", // hilangkan “0/1”
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE2E2E2)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                // pindah ke kotak berikutnya
                FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
              }

              if (value.isEmpty && index > 0) {
                // kembali ke kotak sebelumnya jika dihapus
                FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }

  String getOtp() {
    return _controllers.map((c) => c.text).join();
  }
}
