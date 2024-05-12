import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_guard/features/alzhiemer/controller/patient_detail_controller.dart';
import 'package:mind_guard/features/depression/controller/depression_controller.dart';
import 'package:mind_guard/features/depression/screen/depression_result_screen.dart';
import 'package:mind_guard/features/history/screen/patient_history.dart';
import 'package:mind_guard/utils/constants/sizes.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class HistoryScreen extends StatelessWidget {
  final PatientDetailsController patientController =
      Get.put(PatientDetailsController());

  final DepressionController depressionController =
      Get.put(DepressionController());

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Patients List',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: TSizes.defaultSpace, right: TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TabBar(tabs: [
                  Tab(
                    child: Text("Alzheimer"),
                  ),
                  Tab(
                    child: Text("Tumour"),
                  ),
                  Tab(
                    child: Text("Depression"),
                  ),
                ]),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildAlzheimerPatientList(),
                      _buildBTPatientList(),
                      _buildDepressedPatientList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlzheimerPatientList() {
    return StreamBuilder(
      stream: patientController.getAlzheimerPatients(),
      builder: (context, data) {
        if (data.data != null && data.hasData) {
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemCount: data.data!.length,
            itemBuilder: (context, index) {
              final patient = data.data![index];
              return RoundedContainer(
                showBorder: true,
                backgroundColor: Colors.transparent,
                child: ListTile(
                  title: Text(
                      "${patient.firstName!.capitalize} ${patient.lastName!.capitalize}"),
                  subtitle: Text('Age: ${patient.age}'),
                  onTap: () => Get.to(() => PatientHistoryScreen(
                        patientID: patient.patientId!,
                        isAlzheimer: true,
                      )),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No patients found.'),
          );
        }
      },
    );
  }

  Widget _buildBTPatientList() {
    return StreamBuilder(
      stream: patientController.getBTPatients(),
      builder: (context, data) {
        if (data.data != null && data.hasData) {
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemCount: data.data!.length,
            itemBuilder: (context, index) {
              final patient = data.data![index];
              return RoundedContainer(
                showBorder: true,
                backgroundColor: Colors.transparent,
                child: ListTile(
                  title: Text(
                      "${patient.firstName!.capitalize} ${patient.lastName!.capitalize}"),
                  subtitle: Text('Age: ${patient.age}'),
                  onTap: () => Get.to(() => PatientHistoryScreen(
                        patientID: patient.patientId!,
                        isAlzheimer: false,
                      )),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No patients found.'),
          );
        }
      },
    );
  }

  Widget _buildDepressedPatientList() {
    return StreamBuilder(
      stream: depressionController.getDepressedPatients(),
      builder: (context, data) {
        if (data.data != null && data.hasData) {
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemCount: data.data!.length,
            itemBuilder: (context, index) {
              final patient = data.data![index];
              return RoundedContainer(
                showBorder: true,
                backgroundColor: Colors.transparent,
                child: ListTile(
                  title: Text(
                      "${patient.firstName!.capitalize} ${patient.lastName!.capitalize}"),
                  subtitle: Text('Age: ${patient.age}'),
                  onTap: () => Get.to(
                    () => DepressionResultScreen(
                      patientID: patient.patientId!,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No patients found.'),
          );
        }
      },
    );
  }
}
