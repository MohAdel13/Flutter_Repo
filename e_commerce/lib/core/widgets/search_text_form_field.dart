import 'package:flutter/material.dart';

class SearchTextFormField extends StatelessWidget {
  void Function(String)? onChanged;
  bool autofocus;
  bool readOnly;
  void Function()? onTap;

  SearchTextFormField({this.autofocus = false, this.readOnly = false, this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 0.2,
              offset: Offset(0,3),
              spreadRadius: 1
          )
        ]
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.black,
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        autofocus: autofocus,
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
      ),
    );
  }
}
