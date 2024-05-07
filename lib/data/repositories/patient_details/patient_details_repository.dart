import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../features/alzhiemer/model/patient_detail_model.dart';

class PatientDetailsRepository extends GetxController {
  static PatientDetailsRepository get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addPatient(PatientDetailModel patient, String hospitalId) async {
    try {
      final patientRef = await _firestore
          .collection('Users')
          .doc(hospitalId)
          .collection('patients')
          .add(patient.toJson());

      patient.patientId = patientRef.id;

      // Update the patient document with the assigned patientId
      await patientRef.update({'patientId': patient.patientId});
    } catch (e) {
      log('Error adding patient: $e');
      rethrow;
    }
  }

  Stream<List<PatientDetailModel>> getPatients(String hospitalId) {
    return _firestore
        .collection('users')
        .doc(hospitalId)
        .collection('patients')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PatientDetailModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> updatePatient(
      PatientDetailModel patient, String hospitalId) async {
    try {
      await _firestore
          .collection('Users')
          .doc(hospitalId)
          .collection('patients')
          .doc(patient.patientId)
          .update(patient.toJson());
    } catch (e) {
      log('Error updating patient: $e');
      rethrow;
    }
  }

  Future<void> deletePatient(String patientId, String hospitalId) async {
    try {
      await _firestore
          .collection('users')
          .doc(hospitalId)
          .collection('patients')
          .doc(patientId)
          .delete();
    } catch (e) {
      log('Error deleting patient: $e');
      rethrow;
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      // Create a reference for the image file
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('mri_images/$fileName.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(imageFile);

      // Get the download URL of the uploaded image
      return await ref.getDownloadURL();
    } catch (e) {
      log('Error uploading image to Firebase Storage: $e');
      return "";
    }
  }
}
