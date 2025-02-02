import 'package:flutter/material.dart';

class ColorData {
  final Color appleForeground;
  final Color appleBackground;
  final Color facebookForeground;
  final Color facebookBackground;
  final Color googleForeground;
  final Color googleBackground;

  const ColorData.dark()
      : appleForeground = Colors.white,
        appleBackground = Colors.black,
        facebookForeground = Colors.white,
        facebookBackground = const Color(0xFF4267B2),
        googleForeground = Colors.black,
        googleBackground = Colors.white;

  const ColorData.light()
      : appleForeground = Colors.white,
        appleBackground = Colors.black,
        facebookForeground = Colors.white,
        facebookBackground = const Color(0xFF4267B2),
        googleForeground = Colors.black,
        googleBackground = Colors.white;
}
