import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/features/authentication/controllers/signup/signup_controller.dart';
import 'package:mind_guard/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TermsAndConditionsCheckBox extends StatelessWidget {
  const TermsAndConditionsCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    final controller = SignUpController.instance;
    return Row(
      children: [
        //CheckBox
        SizedBox(
          height: 24,
          width: 24,
          child: Obx(
            () => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) {
                  controller.privacyPolicy.value =
                      !controller.privacyPolicy.value;
                }),
          ),
        ),

        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${TTexts.iAgreeTo} ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      decoration: TextDecoration.underline,
                      color: isDarkMode ? TColors.white : TColors.primary,
                      decorationColor:
                          isDarkMode ? TColors.white : TColors.primary,
                    ),
              ),
              TextSpan(
                text: " ${TTexts.and} ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      decoration: TextDecoration.underline,
                      color: isDarkMode ? TColors.white : TColors.primary,
                      decorationColor:
                          isDarkMode ? TColors.white : TColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
