import 'package:flutter/material.dart';

extension RedAsterisk on Text {
  Text withRedAsterisk(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: data,
            style: style,
          ),
          TextSpan(
            text: '*',
            style: style?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      style: style,
      selectionColor: selectionColor,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
