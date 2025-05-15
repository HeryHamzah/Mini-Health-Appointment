import 'package:flutter/material.dart';

extension HexColorExtension on Color {
  /// Convert Color to hex string like `#RRGGBB` or `#AARRGGBB` if [includeAlpha] is true.
  String toHex({bool includeAlpha = false}) {
    return '#'
            '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
            '${red.toRadixString(16).padLeft(2, '0')}'
            '${green.toRadixString(16).padLeft(2, '0')}'
            '${blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}
