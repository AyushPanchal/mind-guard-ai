// To parse this JSON data, do
//
//     final depressedPatientDetailModel = depressedPatientDetailModelFromJson(jsonString);

import 'dart:convert';

DepressedPatientDetailModel depressedPatientDetailModelFromJson(String str) =>
    DepressedPatientDetailModel.fromJson(json.decode(str));

String depressedPatientDetailModelToJson(DepressedPatientDetailModel data) =>
    json.encode(data.toJson());

class DepressedPatientDetailModel {
  String? timeStamp;
  String? firstName;
  String? lastName;
  String? predictionResult;
  String? phoneNumber;
  String? gender;
  String? patientId;
  List<String>? patientAnswers;
  String? age;
  String? email;
  String? info;

  DepressedPatientDetailModel({
    this.timeStamp,
    this.firstName,
    this.lastName,
    this.predictionResult,
    this.phoneNumber,
    this.gender,
    this.patientId,
    this.patientAnswers,
    this.age,
    this.email,
    this.info,
  });

  DepressedPatientDetailModel copyWith({
    String? timeStamp,
    String? firstName,
    String? lastName,
    String? predictionResult,
    String? phoneNumber,
    String? gender,
    String? patientId,
    List<String>? patientAnswers,
    String? age,
    String? email,
    String? info,
  }) =>
      DepressedPatientDetailModel(
        timeStamp: timeStamp ?? this.timeStamp,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        predictionResult: predictionResult ?? this.predictionResult,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        gender: gender ?? this.gender,
        patientId: patientId ?? this.patientId,
        patientAnswers: patientAnswers ?? this.patientAnswers,
        age: age ?? this.age,
        email: email ?? this.email,
        info: info ?? this.info,
      );

  factory DepressedPatientDetailModel.fromJson(Map<String, dynamic> json) =>
      DepressedPatientDetailModel(
        timeStamp: json["timeStamp"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        predictionResult: json["predictionResult"],
        phoneNumber: json["phoneNumber"],
        gender: json["gender"],
        patientId: json["patientId"],
        patientAnswers: List<String>.from(json["patientAnswers"].map((x) => x)),
        age: json["age"],
        email: json["email"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "timeStamp": timeStamp,
        "firstName": firstName,
        "lastName": lastName,
        "predictionResult": predictionResult,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "patientId": patientId,
        "patientAnswers": List<dynamic>.from(patientAnswers!.map((x) => x)),
        "age": age,
        "email": email,
        "info": info,
      };
}
