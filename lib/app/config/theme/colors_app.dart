import 'package:flutter/material.dart';

abstract class ColorsApp {
  //
  static const Color primary = Color(0xFFFFB300);
  //
  static const Map<int, Color> swatch = {
    50: Color(0xFFfffaeb),
    100: Color(0xFFfff2c6),
    200: Color(0xFFffe288),
    300: Color(0xFFffca40),
    400: Color(0xFFffb720),
    500: Color(0xFFf99507),
    600: Color(0xFFdd6e02),
    700: Color(0xFFb74b06),
    800: Color(0xFF94390c),
    900: Color(0xFF7a300d),
    950: Color(0xFF461702),
  };

  static const MaterialColor primeColor = MaterialColor(0xFFffca40, swatch);
}
