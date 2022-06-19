import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeData extends ChangeNotifier {
  var homeData = [];
  var boardItem = {};
  final fireStore = FirebaseFirestore.instance;


  late String _image;
  String get image => _image;
  late String _content;
  String get content => _content;
  var _now;
  DateTime get now => _now;

  // 처음 홈에서 렌더링 될 때 나오는 아이템 데이터를 불러옴
  getData() async{
    try {
      var fishResult = await fireStore.collection('item').orderBy('date', descending: true).get();
      for (var doc in fishResult.docs) {homeData.add(doc.data());}
    } catch (e) {
      print(e);
    }
    print(homeData);

    notifyListeners();
  }

  // Upload 페이지에서 사진과 글을 생성할 때 사용됨
  putData(image, content, now){
      boardItem['id'] = 3;
      boardItem['likes'] = 0;
      boardItem['user'] = 'GilDong Hong';
      boardItem['liked'] = false;
      boardItem['date'] =  DateFormat('MMM dd').format(now);
      // 여기를 또 바꿔야 함
      boardItem['image'] = image;
      boardItem['content'] = content;
      print('업로드 $boardItem');
      homeData.insert(0, boardItem);

      notifyListeners();
  }


  // 무한스크롤처럼 자동으로 api를 호출해서 자동으로 데이터를 가져온다.
  getMoreData() async{
    var rawData = await http.get(Uri.parse('https://codingapple1.github.io/app/more2.json'));
    var moreData = await jsonDecode(rawData.body);
    print('moreData : $moreData');
    addData(moreData);

    notifyListeners();
  }
  addData(data){
    print('추가 데이터 $data');
    homeData.add(data);
    notifyListeners();
  }
}