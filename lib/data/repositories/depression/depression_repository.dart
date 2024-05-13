import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mind_guard/features/depression/model/depressed_patient_model.dart';
import 'package:mind_guard/utils/constants/api_constants.dart';

class DepressionRepository extends GetxController {
  static DepressionRepository get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final depressionCollection = "depression_collection";
  final userCollection = "Users";

  Stream<List<DepressedPatientDetailModel>> getDepressionPatients(
      String hospitalId) {
    return _firestore
        .collection(userCollection)
        .doc(hospitalId)
        .collection(depressionCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DepressedPatientDetailModel.fromJson(doc.data()))
            .toList());
  }

  Stream<DepressedPatientDetailModel> getCurrentDepressionPatient(
      String patientID, String hospitalId) {
    return _firestore
        .collection(userCollection)
        .doc(hospitalId)
        .collection(depressionCollection)
        .doc(patientID)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data()!;
      log("$data");
      return DepressedPatientDetailModel.fromJson(data);
    });
  }

  Future<void> addDepressionPatient(
      DepressedPatientDetailModel patient, String hospitalId) async {
    try {
      final patientRef = await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(depressionCollection)
          .add(patient.toJson());

      patient.patientId = patientRef.id;

      // Update the patient document with the assigned patientId
      await patientRef.update({'patientId': patient.patientId});
    } catch (e) {
      log('Error adding patient: $e');
      // rethrow;
    }
  }

  Future<void> deleteDepressionPatient(
      String patientId, String hospitalId) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(depressionCollection)
          .doc(patientId)
          .delete();
    } catch (e) {
      log('Error deleting patient: $e');
      rethrow;
    }
  }

  Future<void> updateDepressionPatient(
      DepressedPatientDetailModel patient, String hospitalId) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(depressionCollection)
          .doc(patient.patientId)
          .update(patient.toJson());
    } catch (e) {
      log('Error updating patient: $e');
      rethrow;
    }
  }

  Future<List<String?>> getPredictionResult(List<String> dataList) async {
    const url =
        '${apiUrl}predict_depression'; // Replace with your Flask server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'patientAnswers': dataList}),
      );

      if (response.statusCode == 200) {
        log("Help");
        return [
          jsonDecode(response.body)["result"],
          jsonDecode(response.body)["info"]
        ];
      } else {
        return ["Could not fetch results", "Could not fetch results"];
      }
    } catch (e) {
      log('Error sending data: $e');
    }
    return ["Could not fetch results", "Could not fetch results"];
  }
}
