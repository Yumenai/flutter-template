import 'package:flutter/material.dart';

class ColorResourceData extends ColorScheme {
  final Color positive;
  final Color onPositive;
  final Color deactivate;
  final Color onDeactivate;

  const ColorResourceData.dark()
      : positive = const Color(0xFF1B5E20),
        onPositive = const Color(0xFFFFFFFF),
        deactivate = const Color(0xFFD0D0D0),
        onDeactivate = const Color(0xFF757575),
        super(
          brightness: Brightness.light,
          primary: const Color(0xFF6750A4),
          onPrimary: const Color(0xFFFFFFFF),
          primaryContainer: const Color(0xFFEADDFF),
          onPrimaryContainer: const Color(0xFF21005D),
          secondary: const Color(0xFF8DA450),
          onSecondary: const Color(0xFFFFFFFF),
          secondaryContainer: const Color(0xFFE8DEF8),
          onSecondaryContainer: const Color(0xFF1D192B),
          error: const Color(0xFFB3261E),
          onError: const Color(0xFFFFFFFF),
          errorContainer: const Color(0xFFF9DEDC),
          onErrorContainer: const Color(0xFF410E0B),
          background: const Color(0xFFFFFBFE),
          onBackground: const Color(0xFF1C1B1F),
          surface: const Color(0xFFFFFBFE),
          onSurface: const Color(0xFF1C1B1F),
        );

  const ColorResourceData.light()
      : positive = const Color(0xFF2E7D32),
        onPositive = const Color(0xFFFFFFFF),
        deactivate = const Color(0xFFD0D0D0),
        onDeactivate = const Color(0xFF757575),
        super(
          brightness: Brightness.light,
          primary: const Color(0xFF6750A4),
          onPrimary: const Color(0xFFFFFFFF),
          primaryContainer: const Color(0xFFEADDFF),
          onPrimaryContainer: const Color(0xFF21005D),
          secondary: const Color(0xFF8DA450),
          onSecondary: const Color(0xFFFFFFFF),
          secondaryContainer: const Color(0xFFE8DEF8),
          onSecondaryContainer: const Color(0xFF1D192B),
          error: const Color(0xFFB3261E),
          onError: const Color(0xFFFFFFFF),
          errorContainer: const Color(0xFFF9DEDC),
          onErrorContainer: const Color(0xFF410E0B),
          background: const Color(0xFFFFFBFE),
          onBackground: const Color(0xFF1C1B1F),
          surface: const Color(0xFFFFFBFE),
          onSurface: const Color(0xFF1C1B1F),
        );

  Color get negative => error;

  Color get onNegative => onError;
}
