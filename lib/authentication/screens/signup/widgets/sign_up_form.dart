import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mind_guard/authentication/screens/signup/widgets/terms_and_conditions_checkbox.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';
import '../verify_email.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          //Last name and First name text form fields
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText("First Name", value),
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(
                      Iconsax.user,
                    ),
                  ),
                  expands: false,
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText("Last Name", value),
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(
                      Iconsax.user,
                    ),
                  ),
                  expands: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //Username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                TValidator.validateEmptyText("username", value),
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(
                Iconsax.user_edit,
              ),
            ),
            expands: false,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(
                Iconsax.direct_right,
              ),
            ),
            expands: false,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(
                Iconsax.call,
              ),
            ),
            expands: false,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //Password
          TextFormField(
            controller: controller.password,
            validator: (value) => TValidator.validatePassword(value),
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(
                Iconsax.password_check,
              ),
              suffixIcon: Icon(
                Iconsax.eye_slash,
              ),
            ),
            expands: false,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          //Terms and conditions checkbox
          const TermsAndConditionsCheckBox(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(
                TTexts.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
