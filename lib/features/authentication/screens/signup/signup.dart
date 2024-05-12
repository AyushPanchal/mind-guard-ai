import 'package:flutter/material.dart';
import 'package:mind_guard/features/authentication/screens/signup/widgets/sign_up_form.dart';

import '/../../../utils/constants/sizes.dart';
import '/../../../utils/constants/text_strings.dart';
import '/../../../utils/helpers/helper_functions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Form
              SignUpForm(isDarkMode: isDarkMode),
              // const SizedBox(
              //   height: TSizes.spaceBtwSections,
              // ),

              // //Divider
              // DividerWithText(
              //   isDarkMode: isDarkMode,
              //   text: TTexts.orSignUpWith,
              // ),
              // const SizedBox(
              //   height: TSizes.spaceBtwSections,
              // ),
              //
              // //Social Buttons FB and Google
              // const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
