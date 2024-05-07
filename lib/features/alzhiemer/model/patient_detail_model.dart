import 'dart:convert';

PatientDetailModel patientDetailModelFromJson(String str) =>
    PatientDetailModel.fromJson(json.decode(str));

String patientDetailModelToJson(PatientDetailModel data) =>
    json.encode(data.toJson());

class PatientDetailModel {
  String? firstName;
  String? lastName;
  String? age;
  String? email;
  String? phoneNumber;
  String? mriUrl;
  String? patientId;
  String? predictionResult;
  String? gender;
  String? timeStamp; // New field for storing timestamp

  PatientDetailModel({
    this.firstName,
    this.lastName,
    this.age,
    this.email,
    this.phoneNumber,
    this.mriUrl,
    this.patientId,
    this.predictionResult,
    this.gender,
    this.timeStamp, // Include timeStamp in constructor
  });

  PatientDetailModel copyWith({
    String? firstName,
    String? lastName,
    String? age,
    String? email,
    String? phoneNumber,
    String? mriUrl,
    String? patientId,
    String? predictionResult,
    String? gender,
    String? timeStamp, // Include timeStamp in copyWith method
  }) =>
      PatientDetailModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        mriUrl: mriUrl ?? this.mriUrl,
        patientId: patientId ?? this.patientId,
        predictionResult: predictionResult ?? this.predictionResult,
        gender: gender ?? this.gender,
        timeStamp: timeStamp ?? this.timeStamp,
      );

  factory PatientDetailModel.fromJson(Map<String, dynamic> json) =>
      PatientDetailModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        age: json["age"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        mriUrl: json["mriUrl"],
        patientId: json["patientId"],
        predictionResult: json["predictionResult"],
        gender: json["gender"],
        timeStamp: json["timeStamp"], // Parse timeStamp from JSON
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "email": email,
        "phoneNumber": phoneNumber,
        "mriUrl": mriUrl,
        "patientId": patientId,
        "predictionResult": predictionResult,
        "gender": gender,
        "timeStamp": timeStamp, // Include timeStamp in JSON output
      };
}
