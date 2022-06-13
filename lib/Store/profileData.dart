import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileData extends ChangeNotifier{
  var profileImgList = [];
  bool isFollow = false;
  var profileImg;

  getProfileImgData() async{
    var rawData = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    if (rawData.statusCode == 200) {
      var jsonData =  await jsonDecode(rawData.body);
      profileImgList = jsonData;
      print('profileImg : $profileImgList');
    }
    else{
      print('statusCode : ${rawData.statusCode}');
    }
    notifyListeners();
  }

  putImage(image){
    if(image.runtimeType == String){
      profileImg = NetworkImage(image);
    }
    else{
      profileImg = FileImage(image);
    }
    notifyListeners();
  }

  follow(){
    isFollow = !isFollow;
    print('isFollow : $isFollow');
    notifyListeners();
  }
}
