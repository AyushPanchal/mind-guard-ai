import 'dart:developer';

import 'package:get/get.dart';
import 'package:mind_guard/common/widgets/loaders/loaders.dart';
import 'package:mind_guard/data/repositories/depression/depression_repository.dart';
import 'package:mind_guard/features/depression/model/depressed_patient_model.dart';
import 'package:flutter/material.dart';
import 'package:mind_guard/features/depression/screen/depression_question_screen.dart';
import 'package:mind_guard/features/depression/screen/depression_result_screen.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../model/question_model.dart';

class DepressionController extends GetxController {
  static DepressionController get instance => Get.find();

  final _authenticationRepository = AuthenticationRepository.instance;
  final _depressionRepository = DepressionRepository.instance;

  DepressedPatientDetailModel depressedPatientDetails =
      DepressedPatientDetailModel();

  final GlobalKey<FormState> depressedPatientDetailFormKey =
      GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final age = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = TextEditingController(text: "Not Specified");
  final patientAnswers = <String>[
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  final questions = [
    Question(
      questionText: 'Little interest or pleasure in doing things?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText: 'Feeling down, depressed, or hopeless?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText: 'Feeling down, depressed, or hopeless?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText: 'Feeling tired or having little energy?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText: 'Poor appetite or overeating?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText:
          'Feeling bad about yourself - or that you are a failure or have let yourself or your family down?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText:
          'Trouble concentrating on things, such as reading the newspaper or watching television?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText:
          'Moving or speaking so slowly that other people could have noticed?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText:
          'Thoughts that you would be better off dead, or of hurting yourself?',
      options: [
        'Not at all.',
        'Several days.',
        'More than half the days.',
        'Nearly every day.'
      ],
    ),
    Question(
      questionText:
          "If you've had any days with issues above, how difficult have these problems made it for you at work home, school, or with other people?",
      options: [
        'Not difficult at all.',
        'Somewhat difficult.',
        'Very difficult.',
        'Extremely difficult.'
      ],
    ),
    // Add more questions similarly
  ].obs;

  final predictionResult = "No data found".obs;
  final predictionInfo = "No info found".obs;

  addDepressionPatientDetails() async {
    if (depressedPatientDetailFormKey.currentState!.validate()) {
      try {
        depressedPatientDetails = DepressedPatientDetailModel(
          firstName: firstName.text,
          lastName: lastName.text,
          age: age.text,
          email: email.text,
          phoneNumber: phoneNumber.text,
          gender: gender.text,
          timeStamp: DateTime.now().toString(),
          patientAnswers: patientAnswers,
        );
        await _depressionRepository.addDepressionPatient(
            depressedPatientDetails, _authenticationRepository.authUser!.uid);
        Get.to(() => const DepressionQuestionScreen());
      } catch (e) {
        // Handle error
        log('Error adding patient: $e');
      }
    }
  }

  submitPatientAnswers() async {
    bool flag = true;
    for (var i = 0; i < patientAnswers.length; i++) {
      if (patientAnswers[i] == "") {
        flag = false;
        break;
      }
    }
    if (flag == false) {
      TLoaders.errorSnackBar(
          title: "Answer all questions",
          message: "It is necessary to answer all questions for precision");
    } else {
      _depressionRepository
          .updateDepressionPatient(
              depressedPatientDetails, _authenticationRepository.authUser!.uid)
          .then((value) => _depressionRepository
                  .getPredictionResult(depressedPatientDetails.patientAnswers!)
                  .then((value) {
                predictionResult.value = value[0]!;
                predictionInfo.value = value[1]!;
                depressedPatientDetails.predictionResult =
                    predictionResult.value;
                depressedPatientDetails.info = predictionInfo.value;
                _depressionRepository.updateDepressionPatient(
                    depressedPatientDetails,
                    _authenticationRepository.authUser!.uid);
              }))
          .then((value) => Get.to(() => DepressionResultScreen(
                patientID: depressedPatientDetails.patientId!,
              )));
    }
  }

  Stream<DepressedPatientDetailModel> getSingleDepressedPatientDetail(
      String patientId) {
    log(patientId);
    log(_authenticationRepository.authUser!.uid);
    return _depressionRepository.getCurrentDepressionPatient(
        patientId, _authenticationRepository.authUser!.uid);
  }

  Stream<List<DepressedPatientDetailModel>> getDepressedPatients() {
    return _depressionRepository
        .getDepressionPatients(_authenticationRepository.authUser!.uid);
  }
}
