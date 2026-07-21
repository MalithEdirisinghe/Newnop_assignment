import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Colors
  static const Color primaryLight = Color(0xFF635BFF); // Rich Indigo
  static const Color primaryVariantLight = Color(0xFF4B44E0);
  static const Color secondaryLight = Color(0xFF00D4B2); // Vibrant Teal
  static const Color backgroundLight = Color(0xFFF8F9FD);
  static const Color surfaceLight = Colors.white;
  static const Color cardLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF1E2022);
  static const Color textSecondaryLight = Color(0xFF6C757D);

  // Dark Colors
  static const Color primaryDark = Color(0xFF7A73FF);
  static const Color secondaryDark = Color(0xFF00E5C3);
  static const Color backgroundDark = Color(0xFF0F172A); // Slate dark
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: secondaryLight,
        surface: surfaceLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryLight,
      ),
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: textPrimaryLight),
        titleTextStyle: GoogleFonts.poppins(
          color: textPrimaryLight,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade100,
        selectedColor: primaryLight.withAlpha(38),
        secondarySelectedColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: GoogleFonts.inter(
          color: textPrimaryLight,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          color: primaryLight,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        titleLarge: GoogleFonts.poppins(
          color: textPrimaryLight,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.poppins(
          color: textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(color: textPrimaryLight),
        bodyMedium: GoogleFonts.inter(color: textSecondaryLight),
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        secondary: secondaryDark,
        surface: surfaceDark,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: textPrimaryDark,
      ),
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDark,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: textPrimaryDark),
        titleTextStyle: GoogleFonts.poppins(
          color: textPrimaryDark,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 3,
        shadowColor: Colors.black.withAlpha(76),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF334155),
        selectedColor: primaryDark.withAlpha(64),
        secondarySelectedColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelStyle: GoogleFonts.inter(
          color: textPrimaryDark,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          color: primaryDark,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        titleLarge: GoogleFonts.poppins(
          color: textPrimaryDark,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.poppins(
          color: textPrimaryDark,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(color: textPrimaryDark),
        bodyMedium: GoogleFonts.inter(color: textSecondaryDark),
      ),
    );
  }
}
