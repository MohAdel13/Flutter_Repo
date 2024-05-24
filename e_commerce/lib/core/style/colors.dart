import 'package:flutter/material.dart';

Color mainColor = const Color(0xff544D80);

final Map<int, Color> colorSwatch = {
  50: const Color(0xff544D80).withOpacity(0.1),
  100: const Color(0xff544D80).withOpacity(0.2),
  200: const Color(0xff544D80).withOpacity(0.3),
  300: const Color(0xff544D80).withOpacity(0.4),
  400: const Color(0xff544D80).withOpacity(0.5),
  500: const Color(0xff544D80).withOpacity(1),
  600: const Color(0xff544D80).withOpacity(0.7),
  700: const Color(0xff544D80).withOpacity(0.8),
  800: const Color(0xff544D80).withOpacity(0.9),
  900: const Color(0xff544D80).withOpacity(1)
};

MaterialColor mainMaterialColor = MaterialColor(0xff544D80, colorSwatch);