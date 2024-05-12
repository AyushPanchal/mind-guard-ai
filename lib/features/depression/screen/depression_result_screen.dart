import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/features/depression/controller/depression_controller.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class DepressionResultScreen extends StatelessWidget {
  const DepressionResultScreen({super.key, required this.patientID});

  final String patientID;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DepressionController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Results",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: StreamBuilder(
            builder: (context, data) {
              log("here");
              if (data.data != null && data.hasData) {
                log("Here data");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: TSizes.spaceBtwSections * 1.5,
                    ),
                    RoundedContainer(
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: Colors.transparent,
                      showBorder: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Patient Details",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          const Divider(),
                          Text(
                              "Name : ${data.data!.firstName!.capitalize} ${data.data!.lastName!.capitalize}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Age : ${data.data!.age}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Gender : ${data.data!.gender}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Phone Number : ${data.data!.phoneNumber}",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Text(
                      "Patient Result",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Divider(),
                    data.data!.predictionResult!.isEmpty
                        ? const CircularProgressIndicator(
                            color: Colors.green,
                          )
                        : Text(
                            "Stage : ${data.data!.predictionResult!}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.green),
                          ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const Divider(),
                    Text(
                      "Stage Info",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    data.data!.info!.isEmpty
                        ? const CircularProgressIndicator(
                            color: TColors.darkGrey,
                          )
                        : Text(
                            data.data!.info!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: TColors.darkGrey),
                          ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.offAll(() => const NavigationMenu()),
                        child: const Text("Continue with new"),
                      ),
                    ),
                  ],
                );
              } else {
                log("Here no data");
                return Container();
              }
            },
            stream: controller.getSingleDepressedPatientDetail(patientID),
          ),
        ),
      ),
    );
  }
}
