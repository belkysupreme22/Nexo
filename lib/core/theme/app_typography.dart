import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme textTheme(TextTheme base) {
    final themed = GoogleFonts.lexendTextTheme(base);

    return themed.copyWith(
      displayLarge: themed.displayLarge?.copyWith(fontWeight: FontWeight.w700),
      displayMedium: themed.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: themed.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: themed.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleLarge: themed.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: themed.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: themed.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      bodyMedium: themed.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      labelLarge: themed.labelLarge?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
