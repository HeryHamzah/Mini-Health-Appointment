import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIconWithLabelWidget extends StatelessWidget {
  final Color? fillColor;
  const AppIconWithLabelWidget({super.key, this.fillColor});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/app_icon_with_label.svg',
      width: 150,
      height: 150,
      fit: BoxFit.contain,
      colorFilter: fillColor != null
          ? ColorFilter.mode(fillColor!, BlendMode.srcIn)
          : null,
    );
  }
}
