import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeminiTheme {
  static const borderColor = Color(0xFF151A1F);
  static const widgetColor = Color(0xFF444D54);
  static const widgetAccentColor = Color(0xFF828C95);
  static const darkGreen = Color(0xFF133E1D);
  static const islandColor = Color(0xFF828C95);
  static const starColor = Color(0xFF9FCAFF);
  static const iconColor = Colors.white;
  static const backgroundColors = [
    Color(0xFFDADFE3),
    Color(0xFFA5ABB0),
  ];
  static const islandColors = [
    Color(0xFF151A1F),
    Color(0xFF444D54),
    Color(0xFF828C95),
  ];
  static const celestialGradient = [
    Color(0xFFDADFE3),
    Color(0xFF828C95),
    Color(0xFF444D54),
  ];
  static const lineColor = Color(0xFF444D54);
  static TextStyle title = GoogleFonts.oswald(
    textStyle: TextStyle(
      color: _textColor,
      letterSpacing: .5,
      fontSize: 27,
    ),
  );
  static TextStyle subtitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: _textColor,
      letterSpacing: .5,
      fontSize: 23.5,
      fontWeight: FontWeight.w600,
    ),
  );
  static TextStyle bodyText = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: _textColor,
      letterSpacing: .5,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  );
}

Color _textColor = Colors.white;
