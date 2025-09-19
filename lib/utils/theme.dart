import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();

  return base.copyWith(
    // Color Scheme
    primaryColor: AppColors.primaryOrange,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primaryOrange,
      secondary: AppColors.green,
      surface: AppColors.white,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.darkGrey,
      background: AppColors.background,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.primaryNavy, // Color for icons and back button
      elevation: 1,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.primaryNavy,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    ),

    // Text Theme
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
      bodyLarge: const TextStyle(color: AppColors.darkGrey),
      bodyMedium: const TextStyle(color: AppColors.midGrey),
      titleLarge: const TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(color: AppColors.primaryNavy),
    ),

    // Input Decoration Theme (for TextFields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
      ),
      hintStyle: const TextStyle(
        color: AppColors.midGrey,
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        color: AppColors.midGrey,
        fontSize: 14,
      ),
    ),
  );
}