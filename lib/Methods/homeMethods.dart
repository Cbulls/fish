import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/Methods/storageMethod.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../Models/posts.dart';

class HomeData extends ChangeNotifier {
  var homeData = [];
  var boardItem = {};
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  int itemCount = 2;

  late String _image;
  String get image => _image;
  late String _content;
  String get content => _content;
  var _now;
  DateTime get now => _now;

  // 처음 홈에서 렌더링 될 때 나오는 아이템 데이터를 불러옴
  getPostData() async {
    try {
      // 만들어진지 가장 최근 순으로
      var fishResult = await firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();
      for (var i = 0; i < 2; i++) {
        print('doc : ${fishResult.docs[i].data()['postId']}');
        homeData.add(fishResult.docs[i].data());
        //getComments(fishResult.docs[i].data()['postId']);
      }
    } catch (e) {
      print(e);
    }
    print('homeData : $homeData');

    notifyListeners();
  }

  // getComments(postId) async {
  //   try {
  //     var comments = await firestore.collection('comments').doc(postId).get();
  //     print('getcomments: ${comments.data()}');
  //     return comments.data()?.length;
  //   } catch (e) {
  //     print(e);
  //   }
  //   print('homeData : $homeData');
  //
  //   notifyListeners();
  // }

  // Upload 페이지에서 사진과 글을 생성할 때 사용됨
  putData(uid, postId, username, likes, image, content, now) {
    boardItem['uid'] = uid;
    boardItem['postId'] = postId;
    boardItem['likes'] = likes;
    boardItem['user'] = username;
    boardItem['liked'] = false;
    boardItem['date'] = DateFormat('MMM dd').format(now);
    boardItem['image'] = image;
    boardItem['content'] = content;
    print('업로드 $boardItem');
    homeData.insert(0, boardItem);
    getPostData();

    notifyListeners();
  }

  uploadPost(description, uid, photo, username) async {
    print('username : $username');
    try {
      String postId = const Uuid().v1();
      String photoUrl = await uploadImageToStorage('posts', photo, true);
      Post post = Post(
        createdAt: DateTime.now(),
        description: description,
        uid: uid,
        likes: 0,
        postId: postId,
        photoUrl: photoUrl,
        username: username,
      );
      firestore.collection('posts').doc(postId).set(post.toJson());
      putData(uid, postId, username, 0, photoUrl, content, DateTime.now());
    } catch (error) {
      print('upload error: $error');
    }
    notifyListeners();
  }

  uploadComment(uid, postId, content, username, photoUrl) async {
    print('comment username : $username');
    try {
      String commentId = const Uuid().v1();
      await firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({
        'uid': uid,
        'username': username,
        'photoUrl': photoUrl,
        'comment': content,
        'commentId': commentId,
        'createdAt': DateTime.now()
      });
    } catch (error) {
      print('upload error: $error');
    }
    notifyListeners();
  }

  // 무한스크롤처럼 자동으로 api를 호출해서 자동으로 데이터를 가져온다.
  getMoreData() async {
    try {
      var fishResult = await firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();
      for (var i = itemCount; i < itemCount + 1; i++) {
        print('doc : ${fishResult.docs[i].data()['postId']}');
        homeData.add(fishResult.docs[i].data());
        //getComments(fishResult.docs[i].data()['postId']);
      }
      itemCount = itemCount + 1;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  pressLike(String postId, String uid, likes) async {
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      print('likes error : $error');
    }
    notifyListeners();
  }
}
