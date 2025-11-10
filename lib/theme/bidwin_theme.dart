import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BidWinTheme {
  BidWinTheme._();

  static const Color red = Color(0xFFE53935);
  static const Color blue = Color(0xFF1E88E5);
  static const Color darkBackground = Color(0xFF0F1115);
  static const Color cardBackground = Color(0xFF1C1F26);

  static ThemeData get themeData {
    final textTheme = GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: red,
      colorScheme: ColorScheme.fromSeed(
        seedColor: red,
        brightness: Brightness.dark,
        primary: red,
        secondary: blue,
        background: darkBackground,
      ),
      textTheme: textTheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground.withOpacity(0.9),
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.4),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: red,
        foregroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}

