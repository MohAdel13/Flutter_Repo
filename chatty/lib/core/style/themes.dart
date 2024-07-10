import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: mainColor,
  ),
  primarySwatch: mainMaterialColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed
  ),
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.cyan,
    cursorColor: mainColor,
    selectionHandleColor: mainColor
  ),

  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20.0),
    scrolledUnderElevation: 0.0,
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey.withOpacity(0.4),
      statusBarIconBrightness: Brightness.dark,
    )
  ),

  primaryColor: mainColor,

  textTheme: TextTheme(
    headlineLarge: const TextStyle(
      color: Colors.black,
      fontSize: 18.0
    ),

    headlineMedium: TextStyle(
      color: mainColor,
      fontSize: 16.0
    ),

    headlineSmall: const TextStyle(
      color: Colors.black,
      fontSize: 16.0
    ),

    titleSmall: const TextStyle(
      color: Colors.grey,
      fontSize: 14.0
    ),

    bodyMedium: const TextStyle(
      color: Colors.black,
      fontSize: 16.0,
    )
  )
);