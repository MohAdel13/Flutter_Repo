import 'package:chatty/core/style/colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  Color? color;

  CustomTextButton({
    required this.onPressed,
    required this.text,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: color ?? mainColor),)
    );
  }
}
