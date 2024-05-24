import 'package:e_commerce/core/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.purpleAccent,
    cursorColor: mainColor
  ),

  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20.0),
    centerTitle: true,
    scrolledUnderElevation: 0.0,
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey.withOpacity(0.4),
      statusBarIconBrightness: Brightness.dark,
    )
  ),
  primaryColor: mainColor,
);

// ThemeData darkTheme = ThemeData(
//   primarySwatch: mainMaterialColor,
//   fontFamily: 'Poppins',
//   backgroundColor: Colors.white,
//   textSelectionTheme: TextSelectionThemeData(
//       selectionColor: Colors.purpleAccent,
//       cursorColor: mainColor
//   ),
//   appBarTheme: AppBarTheme(
//       scrolledUnderElevation: 0.0,
//       color: Colors.white,
//       systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: mainColor,
//         statusBarIconBrightness: Brightness.light,
//       )
//   ),
//   primaryColor: mainColor,
// );