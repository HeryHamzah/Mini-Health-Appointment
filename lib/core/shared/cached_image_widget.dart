import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/shared/shimmer_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CachedImageWidget extends StatelessWidget {
  final String? uri;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final Widget? nullWidget;

  const CachedImageWidget({
    super.key,
    this.uri,
    this.errorWidget,
    this.nullWidget,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImage(context, uri);
  }

  Widget _buildImage(BuildContext context, String? imagePath) {
    if (imagePath == null) {
      return nullWidget ??
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: PhosphorIcon(
              PhosphorIconsRegular.image,
            ),
          );
    }

    return CachedNetworkImage(
      imageUrl: imagePath,
      errorWidget: errorWidget ??
          (context, url, error) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: PhosphorIcon(
                  PhosphorIconsRegular.imageBroken,
                ),
              ),
      placeholder: (context, url) => ShimmerWidget(),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
