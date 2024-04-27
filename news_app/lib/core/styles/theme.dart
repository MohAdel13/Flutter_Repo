import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.deepOrange,
    selectionColor: Colors.orange,
    selectionHandleColor: Colors.deepOrangeAccent,
  ),
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.deepOrange,
  primarySwatch: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0.0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
  )
);

ThemeData darkTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.deepOrange,
    selectionColor: Colors.orange,
    selectionHandleColor: Colors.deepOrangeAccent,
  ),
  scaffoldBackgroundColor: const Color(0xff121212),
  primaryColor: Colors.deepOrange,
  primarySwatch: Colors.deepOrange,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffD8C4A4)),
    scrolledUnderElevation: 0.0,
    titleTextStyle: TextStyle(color: Color(0xffD8C4A4), fontSize: 25.0, fontWeight: FontWeight.bold),
    backgroundColor: Color(0xff121212),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff121212),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.black45,
    backgroundColor: Colors.white70
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
  )
);