import 'package:flutter/material.dart';

import '../style/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final  Widget? suffix;
  bool obscure;
  CustomTextFormField(
    {required this.controller,
      required this.label,
      required this.validator,
      required this.type,
      this.prefix,
      this.suffix,
      this.obscure = false
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: type,
      cursorColor: mainColor,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(12.0)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12.0)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(12.0)
        ),
      ),
      validator: validator
    );
  }
}
