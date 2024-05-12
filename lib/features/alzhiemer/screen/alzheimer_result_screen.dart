import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/common/widgets/appbar/appbar.dart';
import 'package:mind_guard/features/alzhiemer/controller/alzheimer_controller.dart';
import 'package:mind_guard/features/alzhiemer/controller/patient_detail_controller.dart';
import 'package:mind_guard/utils/constants/colors.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/sizes.dart';

class AlzheimerResultScreen extends StatelessWidget {
  const AlzheimerResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AlzheimerController.instance;
    final patientController = PatientDetailsController.instance;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: StreamBuilder(
                  builder: (context, data) {
                    if (data.data != null && data.hasData) {
                      return RoundedContainer(
                        padding: const EdgeInsets.all(TSizes.sm),
                        backgroundColor: Colors.transparent,
                        showBorder: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Patient Details",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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
                      );
                    } else {
                      return Container();
                    }
                  },
                  stream: patientController.getSingleAlzheimerPatient(
                      patientController.patientDetails.patientId!),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections * 0.5,
              ),
              Center(
                child: Text(
                  "Patient MRI",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                () => Center(
                  child: RoundedContainer(
                    height: 208,
                    width: 208,
                    backgroundColor: Colors.black,
                    showBorder: true,
                    child: controller.imageFile.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: FileImage(controller.imageFile.value!),
                            ),
                          )
                        : const Center(child: Text("Please Select an Image")),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections * 0.5,
              ),
              Obx(
                () => controller.result.value.isEmpty
                    ? const CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : Text(
                        "Stage : ${controller.result.value}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.green),
                      ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                "Stage Info",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                () => controller.result.value.isEmpty
                    ? const CircularProgressIndicator(
                        color: TColors.darkGrey,
                      )
                    : Text(
                        controller.resultInfo.value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: TColors.darkGrey),
                      ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                  child: const Text("Continue with new"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
