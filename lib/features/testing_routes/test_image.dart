import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;

  Future<void> _getImageAndUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Upload image to Flask server
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    const url =
        'http://192.168.1.5:5000/predict'; // Replace with Flask server URL

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      // Handle response from server if needed
      var responseBody = await response.stream.bytesToString();
      var predictionResult = jsonDecode(responseBody);
      print('Prediction result: $predictionResult');
    } else {
      print('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MRI Image Upload'),
      ),
      body: Center(
        child: _imageFile != null
            ? Image.file(_imageFile!)
            : Text('No image selected'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndUpload,
        tooltip: 'Pick Image',
        child: Icon(Icons.image),
      ),
    );
  }
}
