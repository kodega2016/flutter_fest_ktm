import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  const AppThemes._();

  static final ThemeData primary = ThemeData(
    fontFamily: GoogleFonts.montserratAlternates().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0.4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.red,
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => AppColors.primaryColor),
      ),
    ),
  );
}
