import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryNeon = Color(0xFFE4FF00); // The vibrant neon green/yellow
  static const Color darkBackground = Color(0xFF0F1115); // Deep navy/black
  static const Color cardDark = Color(0xFF1A1D24); // Slightly elevated dark
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF8B93A0);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryNeon,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(
          color: textWhite,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.inter(
          color: textWhite,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.inter(
          color: textWhite,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.inter(color: textWhite),
        bodyMedium: GoogleFonts.inter(color: textGrey),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNeon,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: -0.2,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkBackground,
        selectedItemColor: primaryNeon,
        unselectedItemColor: textGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
