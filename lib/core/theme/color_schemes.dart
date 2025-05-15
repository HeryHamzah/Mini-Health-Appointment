import 'package:flutter/material.dart';

ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0XFF17B8A6), brightness: Brightness.light);

ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0XFF17B8A6), brightness: Brightness.dark);

ColorScheme lightColorScheme = _lightColorScheme.copyWith(
  brightness: Brightness.light,
  primary: const Color(0XFF17B8A6),
);

ColorScheme darkColorScheme = _darkColorScheme.copyWith(
  brightness: Brightness.dark,
  // primary: const Color(0XFF3e78dd), //TODO
);
