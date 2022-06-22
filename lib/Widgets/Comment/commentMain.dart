import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Methods/loginSignupMethods.dart';
import './commentInput.dart';
import 'commentItem.dart';

class CommentMain extends StatelessWidget {
  CommentMain({Key? key, required this.postId}) : super(key: key);

  final postId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream:
            context.watch<LoginSignupData>().authentication.authStateChanges(),
        builder: (context, snapshot) {
          print('snapshot : ${snapshot.data}');
          return Column(
            children: [
              snapshot.hasData ? commentsList(postId) : const SizedBox(),
              const Divider(
                height: 15.0,
                color: Colors.grey,
              ),
              CommentInput(
                snapshot: snapshot,
                postId: postId,
              )
            ],
          );
        });
  }

  Widget commentsList(postId) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) =>
                CommentItem(snapshot: snapshot.data!.docs[index])),
          );
        });
  }
}
