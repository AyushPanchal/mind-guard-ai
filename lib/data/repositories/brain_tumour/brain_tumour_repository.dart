import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mind_guard/utils/constants/api_constants.dart';

class BTRepository extends GetxController {
  static BTRepository get instance => Get.find();

  Future<Map<String, String>> uploadImage(File image) async {
    const url = '${apiUrl}predict_bt';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      // Handle response from server if needed
      // jsonDecode(response.body)['message'];
      var responseBody = await response.stream.bytesToString();

      log("response body $responseBody");

      var predictionResult = jsonDecode(responseBody)["prediction"];
      var predictionInfo = jsonDecode(responseBody)["info"];
      log('Prediction result: $predictionResult');
      return {
        "predictionResult": predictionResult,
        "predictionInfo": predictionInfo,
      };
    } else {
      log('Failed to upload image');
      return {
        "predictionResult": "",
        "predictionInfo": "",
      };
    }
  }
}
