import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isPass;
  final IconButton? suffixIcon;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPass = false,
    this.suffixIcon,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
