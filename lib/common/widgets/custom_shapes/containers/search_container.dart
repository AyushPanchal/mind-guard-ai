import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onPressed,
    this.padding,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: padding,
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          color: showBackground
              ? isDarkMode
                  ? TColors.dark
                  : TColors.light
              : Colors.transparent,
          border: showBorder ? Border.all(color: TColors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: TColors.darkerGrey,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: TColors.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
