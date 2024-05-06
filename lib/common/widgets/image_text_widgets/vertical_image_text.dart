import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class VerticalImageAndText extends StatelessWidget {
  const VerticalImageAndText({
    super.key,
    required this.image,
    required this.text,
    this.textColor = TColors.white,
    this.backgroundColor,
    this.onPressed,
  });

  final String image, text;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor ??
                    (isDarkMode ? TColors.black : TColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
                color: isDarkMode ? TColors.light : TColors.dark,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
