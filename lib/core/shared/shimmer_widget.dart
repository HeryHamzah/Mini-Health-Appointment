import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.outlineVariant,
          highlightColor: Theme.of(context).colorScheme.onPrimary,
          enabled: true,
          child: Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.shadow,
            // child: child,
          ),
        ),
      ),
    );
  }
}
