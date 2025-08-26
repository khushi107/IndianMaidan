import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColors.saffron,
    scaffoldBackgroundColor: AppColors.bgTop,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.navy,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.navy,
      displayColor: AppColors.navy,
    ),
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.saffron,
      secondary: AppColors.green,
      surface: AppColors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black26,
        elevation: 6,
        backgroundColor: AppColors.saffron,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
