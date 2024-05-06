import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.height = 56,
    this.width = 56,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding = const EdgeInsets.all(TSizes.sm),
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
    this.overlayColor,
  });

  final double? height, width;
  final double borderRadius;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor, overlayColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(
                    imageUrl,
                  ) as ImageProvider,
            color: overlayColor,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
