import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String uid;
  String postId;
  String photoUrl;
  String description;
  String username;
  List likes;
  DateTime createdAt;

  Post({
    required this.uid,
    required this.postId,
    required this.photoUrl,
    required this.description,
    required this.username,
    required this.likes,
    required this.createdAt,
  });

  // DocumentSnapshot : Firestore에서 실시간 데이터를 주고받을 때 사용하는 용도
  Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot["username"],
      postId: snapshot["postId"],
      uid: snapshot["uid"],
      description: snapshot["description"],
      photoUrl: snapshot["photoUrl"],
      likes: snapshot["likes"],
      createdAt: snapshot["createdAt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "postId": postId,
        "uid": uid,
        "description": description,
        "photoUrl": photoUrl,
        "likes": likes,
        "createdAt": createdAt,
      };
}
