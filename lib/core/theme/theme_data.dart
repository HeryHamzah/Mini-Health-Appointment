import 'package:flutter/material.dart';

import 'color_schemes.dart';

class AppTheme {
  static ThemeData themeData(BuildContext context, Brightness brightness) {
    ThemeData baseTheme = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    ColorScheme colorScheme =
        brightness == Brightness.dark ? darkColorScheme : lightColorScheme;

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: 'Poppins',
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          fixedSize: Size.fromHeight(49),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outlineVariant)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outlineVariant)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outlineVariant)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.primary)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          fixedSize: Size.fromHeight(49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
          color: colorScheme.onPrimary,
          shadowColor: colorScheme.onPrimary.withValues(alpha: 0.1)),
    );
  }
}
