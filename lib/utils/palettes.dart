import 'package:flutter/material.dart';

class Palettes {

  Palettes._();

  static const int _whiteValue = 0xFFFFFFFF;
  static const int _blackValue = 0xFF222323;
  static const int _greyValue = 0xFFC7C7C7;
  static const int _accentMainValue = 0xFF00AA6C;
  static const int _accentYellowValue = 0xFFFFC440;
  static const int _accentRedValue = 0xFFFF7043;

  static const Color transparent = Colors.transparent;
  static const Color pureBlack = Colors.black;

  static const MaterialColor white = MaterialColor(
    _whiteValue,
    <int, Color>{
      50: Color.fromRGBO(255, 255, 255, 0.5),
      95: Color.fromRGBO(255, 255, 255, 0.95),
      500: Color.fromRGBO(255, 255, 255, 1.0),
    },
  );
}