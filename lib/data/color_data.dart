import 'package:flutter/material.dart';

class ColorData {
  final Color apple;
  final Color onApple;
  final Color facebook;
  final Color onFacebook;
  final Color google;
  final Color onGoogle;
  final Color negative;
  final Color onNegative;
  final Color positive;
  final Color onPositive;

  const ColorData.dark()
      : apple = Colors.black,
        onApple = Colors.white,
        facebook = const Color(0xFF4267B2),
        onFacebook = Colors.white,
        google = Colors.white,
        onGoogle = Colors.black,
        negative = const Color(0xFFB71C1C),
        onNegative = Colors.white,
        positive = const Color(0xFF33691E),
        onPositive = Colors.white;

  const ColorData.light()
      : apple = Colors.black,
        onApple = Colors.white,
        facebook = const Color(0xFF4267B2),
        onFacebook = Colors.white,
        google = Colors.white,
        onGoogle = Colors.black,
        negative = const Color(0xFFB71C1C),
        onNegative = Colors.white,
        positive = const Color(0xFF33691E),
        onPositive = Colors.white;
}
