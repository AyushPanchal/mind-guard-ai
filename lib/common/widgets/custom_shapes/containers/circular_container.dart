import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.radius = 400,
    this.backgroundColor = TColors.white,
    this.child,
    this.margin,
  });
  final double? height;
  final double? width;
  final double radius;
  final Color? backgroundColor;
  final Widget? child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
