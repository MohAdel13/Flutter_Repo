import 'dart:core';

import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget{
  final TextEditingController controller;
  final String labelText;
  bool readOnly;
  void Function()? onTap;
  final Icon prefixIcon;
  final TextInputType type;
  String? Function(String?)? validator;

  CustomTextFormFieldWidget({
    super.key, required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.type,
    this.validator,
    this.readOnly = false,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade900),
            borderRadius: BorderRadius.circular(5.0)
        ),
        labelText: labelText,
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        prefixIcon: prefixIcon,
      ),
      readOnly: readOnly,
      cursorColor: Colors.grey,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      validator: validator,
    );
  }

}