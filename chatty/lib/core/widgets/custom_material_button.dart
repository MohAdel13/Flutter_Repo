import 'package:chatty/core/style/colors.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {

  final void Function() onPressed;
  final String text;
  Color? color;

  CustomMaterialButton({
    required this.onPressed,
    required this.text,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0)
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        color: color ?? mainColor,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 20.0))
        ),
      ),
    );
  }
}
