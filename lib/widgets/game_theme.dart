import 'package:flutter/material.dart';

class GameTheme {
  // =========================
  // PRIMARY COLORS
  // =========================

  static const Color primary = Color(0xFF4F46E5);

  static const Color secondary = Color(0xFF7C3AED);

  static const Color accent = Color(0xFF06B6D4);

  static const Color success = Color(0xFF10B981);

  static const Color danger = Color(0xFFEF4444);

  static const Color warning = Color(0xFFF59E0B);

  static const Color dark = Color(0xFF0F172A);

  static const Color light = Color(0xFFF8FAFC);

  // =========================
  // GRADIENTS
  // =========================

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [
      success,
      Color(0xFF14B8A6),
    ],
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [
      danger,
      Color(0xFFDC2626),
    ],
  );

  // =========================
  // SHADOWS
  // =========================

  static List<BoxShadow> shadow({
    Color color = primary,
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(
          0.22,
        ),
        blurRadius: 16,
        offset: const Offset(
          0,
          8,
        ),
      ),
    ];
  }

  // =========================
  // BORDER RADIUS
  // =========================

  static BorderRadius radiusLg = BorderRadius.circular(
    30,
  );

  static BorderRadius radiusMd = BorderRadius.circular(
    22,
  );

  static BorderRadius radiusSm = BorderRadius.circular(
    16,
  );

  // =========================
  // THEME DATA
  // =========================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: light,
    primaryColor: primary,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: radiusMd,
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radiusLg,
      ),
    ),
  );

  // =========================
  // DARK THEME
  // =========================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: dark,
    primaryColor: primary,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: radiusMd,
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(
        0xFF1E293B,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: radiusLg,
      ),
    ),
  );
}
