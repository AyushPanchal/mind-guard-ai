import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AlzheimerRepository extends GetxController {
  static AlzheimerRepository get instance => Get.find();

  Future<String> uploadImage(File image) async {
    const url = 'http://192.168.1.4:5000/predict';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      // Handle response from server if needed
      // jsonDecode(response.body)['message'];
      var responseBody = await response.stream.bytesToString();

      log("response body $responseBody");

      var predictionResult = jsonDecode(responseBody)["prediction"];
      log('Prediction result: $predictionResult');
      return predictionResult;
    } else {
      log('Failed to upload image');
      return "";
    }
  }
}
