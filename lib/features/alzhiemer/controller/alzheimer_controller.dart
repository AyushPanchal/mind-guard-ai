import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_guard/data/repositories/alzhiemer/alzhiemer_repository.dart';
import 'package:mind_guard/data/repositories/authentication/authentication_repository.dart';
import 'package:mind_guard/data/repositories/patient_details/patient_details_repository.dart';
import 'package:mind_guard/features/alzhiemer/controller/patient_detail_controller.dart';
import 'package:mind_guard/features/alzhiemer/model/patient_detail_model.dart';

class AlzheimerController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  final AlzheimerRepository _alzheimerRepository = AlzheimerRepository.instance;
  final result = "Upload image".obs;
  final _patientDetailsRepository = PatientDetailsRepository.instance;
  final _authenticationRepository = AuthenticationRepository.instance;
  final _patientDetailController = PatientDetailsController.instance;

  Future<void> getImageAndUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    result.value = "";

    log("Message : ${result.value}");

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      String mriImageUrl = await _patientDetailsRepository
          .uploadImageToStorage(imageFile.value!);
      _patientDetailController.patientDetails =
          _patientDetailController.patientDetails.copyWith(mriUrl: mriImageUrl);
      _patientDetailsRepository
          .updatePatient(_patientDetailController.patientDetails,
              _authenticationRepository.authUser!.uid)
          .then((value) => log("SuccessFull MRI Image"));

      // Upload image to Flask server
      result.value = await _alzheimerRepository.uploadImage(imageFile.value!);
      _patientDetailController.patientDetails = _patientDetailController
          .patientDetails
          .copyWith(predictionResult: result.value);
      _patientDetailsRepository
          .updatePatient(_patientDetailController.patientDetails,
              _authenticationRepository.authUser!.uid)
          .then((value) => log("SuccessFull Prediction Stored"));
    }

    log("Message : ${result.value}");
  }
}
