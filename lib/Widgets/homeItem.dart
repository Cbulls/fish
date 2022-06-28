import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Methods/homeMethods.dart';
import 'package:instagram/Widgets/Comment/commentMain.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Pages/profilePage.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  var scrollController = ScrollController();
  int countAPI = 0;
  bool isChatOpen = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          countAPI < context.read<HomeData>().homeData.length) {
        context.read<HomeData>().getMoreData();
        countAPI++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  final snap = snapshot.data!.docs[index].data();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            foregroundImage: NetworkImage(snap['photoUrl']),
                          ),
                          title: GestureDetector(onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Profile(
                                          profileImage: snap['photoUrl'],
                                          user: snap['username'],
                                        )
                                )
                            );
                          },
                            child: Text(
                                snap['username'], style: const TextStyle(
                              fontSize: 25,
                            )),
                          ),
                          trailing: StreamBuilder<User?>(
                              stream: context.watch<LoginSignupData>().authentication.authStateChanges(),
                              builder: (context, snapshot) {
                                if (snapshot.data?.uid == snap['uid']) {
                                  return GestureDetector(child: const Icon(
                                    Icons.delete, color: Colors.black,),
                                      onTap: () {
                                        context.read<HomeData>().deletePost(
                                            snap['postId']);
                                      });
                                }
                                return const SizedBox();
                              }
                          ),
                        ),
                      ),
                      snap['photoUrl'].runtimeType == String
                          ? Image.network(snap['photoUrl'])
                          : Image.file(snap['photoUrl']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: TextButton.icon(
                                onPressed: () {
                                  context.read<HomeData>().pressLike(
                                      snap['postId'], snap['uid'],
                                      snap['likes']);
                                },
                                label: Text(
                                  snap["likes"].length.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                icon: snap["likes"].contains(
                                    snap['uid'] ?? '유저없음')
                                    ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                                    : const Icon(Icons.favorite_border,
                                    color: Colors.grey),
                              )
                          ),
                          TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  isChatOpen = !isChatOpen;
                                  print('isChatOpen : $isChatOpen');
                                });
                              },
                              label: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(snap['postId'])
                                      .collection('comments')
                                      .orderBy('createdAt', descending: false)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                    return snapshot.hasData
                                        ? Text(
                                      snapshot.data!.docs.length.toString(),
                                      style: const TextStyle(
                                          color: Colors.black),
                                    )
                                        : const Text('0');
                                  }),
                              icon: isChatOpen
                                  ? const Icon(
                                Icons.chat,
                                color: Colors.green,
                              )
                                  : const Icon(
                                Icons.chat_outlined,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      Text(snap['description']),
                      isChatOpen
                          ? CommentMain(
                          postId: snap['postId'])
                          : const SizedBox()
                    ],
                  );
                });
          } return const SizedBox();
        });
  }
}
