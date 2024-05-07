import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mind_guard/data/repositories/authentication/authentication_repository.dart';
import 'package:mind_guard/data/repositories/patient_details/patient_details_repository.dart';
import 'package:mind_guard/features/alzhiemer/model/patient_detail_model.dart';
import 'package:mind_guard/features/alzhiemer/screen/alzhimer_screen.dart';

class PatientDetailsController extends GetxController {
  static PatientDetailsController get instance => Get.find();

  final PatientDetailsRepository _patientDetailsRepository =
      PatientDetailsRepository.instance;
  final _authenticationRepository = AuthenticationRepository.instance;
  PatientDetailModel patientDetails = PatientDetailModel();

  final GlobalKey<FormState> patientDetailFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final age = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = TextEditingController();

  addPatientDetails() async {
    if (patientDetailFormKey.currentState!.validate()) {
      try {
        patientDetails = PatientDetailModel(
          firstName: firstName.text,
          lastName: lastName.text,
          age: age.text,
          email: email.text,
          phoneNumber: phoneNumber.text,
          gender: gender.text,
          timeStamp: DateTime.now().toString(),
        );
        await _patientDetailsRepository.addPatient(
            patientDetails, _authenticationRepository.authUser!.uid);
        Get.to(() => const AlzheimerScreen());
      } catch (e) {
        // Handle error
        log('Error adding patient: $e');
      }
    }
  }
}
