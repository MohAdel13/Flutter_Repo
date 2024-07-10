import 'package:flutter/material.dart';

Color mainColor = const Color(0xFF008B8B);

final Map<int, Color> colorSwatch = {
  50: mainColor.withOpacity(0.1),
  100: mainColor.withOpacity(0.2),
  200: mainColor.withOpacity(0.3),
  300: mainColor.withOpacity(0.4),
  400: mainColor.withOpacity(0.5),
  500: mainColor.withOpacity(1),
  600: mainColor.withOpacity(0.7),
  700: mainColor.withOpacity(0.8),
  800: mainColor.withOpacity(0.9),
  900: mainColor.withOpacity(1)
};

MaterialColor mainMaterialColor = MaterialColor(0xFF008B8B, colorSwatch);