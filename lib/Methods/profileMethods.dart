import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Pages/uploadPage.dart';

class ProfileData extends ChangeNotifier {
  var imageListInProfile = [];
  bool isFollow = false;
  var imageInProfile;
  var uploadedImage;
  var profileImage;

  getProfileImgData() async {
    var rawData = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    if (rawData.statusCode == 200) {
      var jsonData = await jsonDecode(rawData.body);
      imageListInProfile = jsonData;
      print('imageListInProfile : $imageListInProfile');
    } else {
      print('statusCode : ${rawData.statusCode}');
    }
    notifyListeners();
  }

  putImage(image) {
    if (image.runtimeType == String) {
      if (Uri.parse(image).isAbsolute) {
        imageInProfile = NetworkImage(image);
        return imageInProfile;
      } else {
        imageInProfile = FileImage(File(image));
        return imageInProfile;
      }
    } else {
      imageInProfile = FileImage(image);
      return imageInProfile;
    }
  }

  showImage(image) {
    if (image != null) {
      return Image.file(image);
    }
  }

  uploadImage(context, String page) async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (page == 'upload') {
        uploadedImage = File(image.path);
        print('uploadedImage : $uploadedImage');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Upload()));
      }
      if (page == 'out') {
        profileImage = File(image.path);
      }
    } else {
      print('No Image');
    }
    notifyListeners();
  }

  follow() {
    isFollow = !isFollow;
    print('isFollow : $isFollow');
    notifyListeners();
  }
}
