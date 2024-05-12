import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/common/widgets/appbar/appbar.dart';
import 'package:mind_guard/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mind_guard/features/depression/controller/depression_controller.dart';
import 'package:mind_guard/utils/constants/colors.dart';
import 'package:mind_guard/utils/constants/sizes.dart';

class DepressionQuestionScreen extends StatelessWidget {
  const DepressionQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DepressionController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Questions"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: TSizes.defaultSpace,
              right: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Instruction",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const RoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(TSizes.sm),
                backgroundColor: Colors.transparent,
                child: Text(
                    "Below is a list of questions that relate to life experiences common among people who have been diagnosed with depression. Please read each question carefully, and indicate how often you have experienced the same or similar challenges in the past few months."),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  return RoundedContainer(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question : ${index + 1}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: TSizes.sm,
                          ),
                          Text(
                            controller.questions[index].questionText,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: TSizes.sm),
                          Column(
                            children: controller.questions[index].options
                                .asMap()
                                .entries
                                .map(
                                  (entry) => Obx(
                                    () => RadioListTile<int>(
                                      selectedTileColor: TColors.white,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(entry.value),
                                      value: entry.key,
                                      groupValue: controller.questions[index]
                                          .selectedOptionIndex.value,
                                      onChanged: (value) {
                                        controller.patientAnswers[index] =
                                            value!.toString();
                                        controller.questions[index]
                                            .selectedOptionIndex.value = value;

                                        log(controller.patientAnswers
                                            .toString());
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.submitPatientAnswers();
                    },
                    child: const Text("Submit")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
