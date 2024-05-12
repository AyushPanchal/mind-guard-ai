import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/common/widgets/appbar/appbar.dart';
import 'package:mind_guard/features/alzhiemer/controller/patient_detail_controller.dart';
import 'package:mind_guard/navigation_menu.dart';
import 'package:mind_guard/utils/constants/colors.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';

class PatientHistoryScreen extends StatelessWidget {
  const PatientHistoryScreen({
    super.key,
    required this.patientID,
    required this.isAlzheimer,
  });

  final String patientID;
  final bool isAlzheimer;

  @override
  Widget build(BuildContext context) {
    // final controller = AlzheimerController.instance;
    final patientController = PatientDetailsController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Patient History",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Delete this patient?"),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel")),
                    ElevatedButton(
                      onPressed: () {
                        patientController
                            .deleteAlzheimerPatientDetails(patientID);
                        Get.offAll(() => const NavigationMenu());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: TSizes.defaultSpace),
                        child: Text("Confirm"),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete_forever,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: StreamBuilder(
            builder: (context, data) {
              final patient = data.data;
              if (patient != null && data.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              "Name : ${patient.firstName!.capitalize} ${patient.lastName!.capitalize}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Age : ${patient.age}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Gender : ${patient.gender}",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("Phone Number : ${patient.phoneNumber}",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
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
                    Center(
                      child: RoundedContainer(
                        height: 208,
                        width: 208,
                        backgroundColor: Colors.black,
                        showBorder: true,
                        child: patient.mriUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image(
                                  image: NetworkImage(patient.mriUrl!),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections * 0.5,
                    ),
                    patient.predictionResult!.isEmpty
                        ? const CircularProgressIndicator(
                            color: Colors.green,
                          )
                        : Text(
                            "Stage : ${patient.predictionResult!}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.green),
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
                    patient.predictionResult!.isEmpty
                        ? const CircularProgressIndicator(
                            color: TColors.darkGrey,
                          )
                        : Text(
                            "${patient.info}",
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
                        onPressed: () => Get.back(),
                        child: const Text("Back"),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
            stream: isAlzheimer
                ? patientController.getSingleAlzheimerPatient(patientID)
                : patientController.getSingleBTPatient(patientID),
          ),
        ),
      ),
    );
  }
}
