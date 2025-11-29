import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color errorColor = Color(0xFFCF6679);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        surfaceBright: backgroundColor,
        error: errorColor,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineMedium: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[300],
            ),
          ),

      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor.withOpacity(0.8),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white,
        surfaceBright: Color(0xFFF5F5F5),
        error: Color(0xFFB00020),
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF212121),
            ),
            headlineMedium: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF212121),
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF212121),
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF616161),
            ),
          ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        foregroundColor: const Color(0xFF212121),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF212121),
        ),
      ),
    );
  }
}
