import 'package:flutter/material.dart';

Widget customTextFormFieldWidget({
  required TextEditingController controller,
  required String labelText,
  bool readOnly = false,
  void Function()? onTap,
  required Icon prefixIcon,
  required TextInputType type,
  String? Function(String?)? validator,
}){
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