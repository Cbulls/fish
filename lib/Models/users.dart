import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String photoUrl;
  String username;
  List followers;
  List following;

  User({
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.followers,
    required this.following,
  });

  // DocumentSnapshot : Firestore에서 실시간 데이터를 주고받을 때 사용하는 용도
  User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "photoUrl": photoUrl,
    "followers": followers,
    "following": following,
  };
}