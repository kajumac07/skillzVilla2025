import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final bool isCircle;
  final BorderRadius? borderRadius;
  final bool enableShimmer;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.height = 60,
    this.width = 60,
    this.fit = BoxFit.cover,
    this.isCircle = false,
    this.borderRadius,
    this.enableShimmer = true,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _fallbackImage();
    }

    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(500)
          : (borderRadius ?? BorderRadius.circular(12)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,

        placeholder: (context, url) => enableShimmer
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.grey.shade300,
                ),
              )
            : Container(
                height: height,
                width: width,
                color: Colors.grey.shade200,
              ),

        errorWidget: (context, url, error) => _fallbackImage(),
      ),
    );
  }

  Widget _fallbackImage() {
    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(500)
          : borderRadius ?? BorderRadius.circular(12),
      child: Image.asset(
        Appimages.profileNew,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
