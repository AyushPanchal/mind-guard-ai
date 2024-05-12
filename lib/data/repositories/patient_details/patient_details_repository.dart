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

  final alzheimerCollection = "alzheimer_patients";
  final btCollection = "brain_tumour_collection";
  final userCollection = "Users";

  Future<void> addAlzheimerPatient(
      PatientDetailModel patient, String hospitalId) async {
    try {
      final patientRef = await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(alzheimerCollection)
          .add(patient.toJson());

      patient.patientId = patientRef.id;

      // Update the patient document with the assigned patientId
      await patientRef.update({'patientId': patient.patientId});
    } catch (e) {
      log('Error adding patient: $e');
      rethrow;
    }
  }

  Stream<PatientDetailModel> getCurrentAlzheimerPatient(
      String patientID, String hospitalId) {
    return _firestore
        .collection(userCollection)
        .doc(hospitalId)
        .collection(alzheimerCollection)
        .doc(patientID)
        .snapshots()
        .map((snapshot) {
      return PatientDetailModel.fromJson(snapshot.data()!);
    });
  }

  Stream<PatientDetailModel> getCurrentBTPatient(
      String patientID, String hospitalId) {
    return _firestore
        .collection(userCollection)
        .doc(hospitalId)
        .collection(btCollection)
        .doc(patientID)
        .snapshots()
        .map((snapshot) {
      return PatientDetailModel.fromJson(snapshot.data()!);
    });
  }

  Stream<List<PatientDetailModel>> getAlzheimerPatients(String hospitalId) {
    return _firestore
        .collection(userCollection)
        .doc(hospitalId)
        .collection(alzheimerCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PatientDetailModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> updateAlzheimerPatient(
      PatientDetailModel patient, String hospitalId) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(alzheimerCollection)
          .doc(patient.patientId)
          .update(patient.toJson());
    } catch (e) {
      log('Error updating patient: $e');
      rethrow;
    }
  }

  Future<void> deleteAlzheimerPatient(
      String patientId, String hospitalId) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(alzheimerCollection)
          .doc(patientId)
          .delete();
    } catch (e) {
      log('Error deleting patient: $e');
      rethrow;
    }
  }

  Future<void> addBTPatient(
      PatientDetailModel patient, String hospitalId) async {
    try {
      final patientRef = await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(btCollection)
          .add(patient.toJson());

      patient.patientId = patientRef.id;

      // Update the patient document with the assigned patientId
      await patientRef.update({'patientId': patient.patientId});
    } catch (e) {
      log('Error adding patient: $e');
      rethrow;
    }
  }

  Stream<List<PatientDetailModel>> getBTPatients(String hospitalId) {
    return _firestore
        .collection(userCollection)
        .doc(hospitalId)
        .collection(btCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PatientDetailModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> updateBTPatient(
      PatientDetailModel patient, String hospitalId) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(btCollection)
          .doc(patient.patientId)
          .update(patient.toJson());
    } catch (e) {
      log('Error updating patient: $e');
      rethrow;
    }
  }

  Future<void> deleteBTPatient(String patientId, String hospitalId) async {
    try {
      await _firestore
          .collection(userCollection)
          .doc(hospitalId)
          .collection(btCollection)
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
