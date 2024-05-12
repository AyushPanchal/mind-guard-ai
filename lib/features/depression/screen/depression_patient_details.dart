import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mind_guard/common/widgets/appbar/appbar.dart';
import 'package:mind_guard/features/depression/controller/depression_controller.dart';
import 'package:mind_guard/utils/constants/sizes.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/validators/validation.dart';

class DepressionPatientDetailsScreen extends StatelessWidget {
  const DepressionPatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DepressionController());
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Depression Prediction"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              Form(
                key: controller.depressedPatientDetailFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Text(
                      "Depressed Patient Details",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    //Last name and First name text form fields
                    TextFormField(
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
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
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
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),

                    TextFormField(
                      controller: controller.age,
                      validator: (value) => TValidator.validateAge(value),
                      decoration: const InputDecoration(
                        labelText: TTexts.age,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                      expands: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    DropdownButtonFormField(
                      padding: EdgeInsets.zero,
                      // value: controller.gender.text,
                      decoration: const InputDecoration(
                          labelText: "Select Gender",
                          prefix: Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Iconsax.sort,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(15.0)),
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.gender.text = value;
                          // log(controller.gender.text);
                        } else {
                          controller.gender.text = "Not Specified";
                        }
                      },
                      items: [
                        "Male",
                        "Female",
                        "Other",
                      ]
                          .map((option) => DropdownMenuItem(
                              value: option, child: Text(option)))
                          .toList(),
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
                      validator: (value) =>
                          TValidator.validatePhoneNumber(value),
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

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.addDepressionPatientDetails(),
                        child: const Text(
                          TTexts.submit,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
