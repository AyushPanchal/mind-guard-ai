import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_guard/data/repositories/authentication/authentication_repository.dart';
import 'package:mind_guard/data/repositories/brain_tumour/brain_tumour_repository.dart';
import 'package:mind_guard/data/repositories/patient_details/patient_details_repository.dart';
import 'package:mind_guard/features/alzhiemer/controller/patient_detail_controller.dart';

class BTController extends GetxController {
  static BTController get instance => Get.find();

  Rx<File?> imageFile = Rx<File?>(null);
  final BTRepository _btRepository = BTRepository.instance;
  final result = "Upload image".obs;
  final resultInfo = "Not available".obs;
  final imageSelected = true.obs;
  final _patientDetailsRepository = PatientDetailsRepository.instance;
  final _authenticationRepository = AuthenticationRepository.instance;
  final _patientDetailController = PatientDetailsController.instance;

  Future<void> getImageAndUpload() async {
    imageSelected.value = false;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    result.value = "";

    log("Message : ${result.value}");

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      imageSelected.value = true;
      String mriImageUrl = await _patientDetailsRepository
          .uploadImageToStorage(imageFile.value!);
      _patientDetailController.patientDetails =
          _patientDetailController.patientDetails.copyWith(mriUrl: mriImageUrl);
      _patientDetailsRepository
          .updateBTPatient(_patientDetailController.patientDetails,
              _authenticationRepository.authUser!.uid)
          .then((value) => log("SuccessFull MRI Image"));

      // Upload image to Flask server
      Map<String, String> results =
          await _btRepository.uploadImage(imageFile.value!);
      result.value = results["predictionResult"]!;
      resultInfo.value = results["predictionInfo"]!;
      _patientDetailController.patientDetails = _patientDetailController
          .patientDetails
          .copyWith(predictionResult: result.value);
      _patientDetailController.patientDetails = _patientDetailController
          .patientDetails
          .copyWith(info: resultInfo.value);
      _patientDetailsRepository
          .updateBTPatient(_patientDetailController.patientDetails,
              _authenticationRepository.authUser!.uid)
          .then((value) => log("SuccessFull Prediction Stored"));
    }

    log("Message : ${result.value}");
  }
}
