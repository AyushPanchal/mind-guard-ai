import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.appBarHeight,
    bottom: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
    left: TSizes.defaultSpace,
  );
}
