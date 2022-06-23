import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Methods/loginSignupMethods.dart';
import './commentInput.dart';
import 'commentItem.dart';

class CommentMain extends StatelessWidget {
  const CommentMain({Key? key, required this.postId}) : super(key: key);

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
              commentsList(postId),
              snapshot.hasData
                  ? Column(children: [
                      const Divider(
                        height: 15.0,
                        color: Colors.grey,
                      ),
                      CommentInput(
                        postId: postId,
                      )
                    ])
                  : const SizedBox()
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
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            // 댓글 창은 이중 스크롤 방지
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) =>
                CommentItem(snapshot: snapshot.data!.docs[index])),
          );
        });
  }
}
