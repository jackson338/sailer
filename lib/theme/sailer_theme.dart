import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SailerTheme {
  static const borderColor = Color(0xFF18140D);
  static const widgetColor = Color(0xFF18140D);
  static const islandColor = Color(0xFF392C19);
  static const starColor = Color(0xFF9FCAFF);
  static const starColors = [
    Colors.white,
    Colors.white,
    Color(0xFF9FCAFF),
    Color(0xFF9FCAFF),
    Color(0xFF9FCAFF),
    Color(0xFF9FCAFF),
    Color(0xFF9FCAFF),
    Color(0xFF9FCAFF),
    Color(0xFF7FAFE7),
    Color(0xFF7FAFE7),
    Color(0xFF7FAFE7),
  ];
  static const backgroundColors = [
    Color(0xFFeae2c6),
    Color(0xFFb4a782),
  ];
  static const islandColors = [
    Color(0xFF918a70),
    Color(0xFFc1bba1),
    Color(0xFFd4cbad),
  ];
  static const celestialGradient = [
    Color(0xFF111A21),
    Color(0xFF243B57),
    Color(0xFF446792),
    Color(0xFFeae2c6),
  ];
  static const lineColor = Color(0xFF948b75);
  static TextStyle title = GoogleFonts.pacifico(
    textStyle: TextStyle(
      color: _textColor,
      letterSpacing: .5,
      fontSize: 27,
    ),
  );
  static TextStyle subtitle = GoogleFonts.satisfy(
    textStyle: TextStyle(
      color: _textColor,
      letterSpacing: .5,
      fontSize: 23.5,
      fontWeight: FontWeight.w600,
    ),
  );
  static TextStyle bodyText = GoogleFonts.dancingScript(
    textStyle: TextStyle(
      color: _textColor,
      letterSpacing: .5,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  );
}

Color _textColor = const Color(0xFF51492f);
