import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle primary(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.primary);

  TextStyle onPrimary(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.onPrimary);
  TextStyle outline(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.outline);

  TextStyle? underline(BuildContext context) => copyWith(
        decoration: TextDecoration.underline,
        decorationColor: color,
      );

  TextStyle? italic(BuildContext context) =>
      copyWith(fontStyle: FontStyle.italic);
}
