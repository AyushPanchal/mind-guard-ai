import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mind_guard/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:mind_guard/utils/validators/validation.dart';

import '/../../../utils/constants/colors.dart';
import '/../../../utils/constants/sizes.dart';
import '/../../../utils/constants/text_strings.dart';
import '/../../../utils/helpers/helper_functions.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_left_2,
            color: isDarkMode ? Colors.grey : TColors.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Headings
            Text(
              TTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              TTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections * 2,
            ),

            //Text Field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                validator: (value) => TValidator.validateEmail(value),
                controller: controller.email,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Submit button
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  controller.sendPasswordResetEmail();
                },
                child: const Text(
                  TTexts.submit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
