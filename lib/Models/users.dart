import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  String uid;
  String photoUrl;
  String username;
  List followers;
  List following;

  ModelUser({
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.followers,
    required this.following,
  });

  // DocumentSnapshot : Firestore에서 실시간 데이터를 주고받을 때 사용하는 용도
  static ModelUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ModelUser(
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
