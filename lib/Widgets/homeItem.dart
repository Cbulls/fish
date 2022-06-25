import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Methods/homeMethods.dart';
import 'package:instagram/Widgets/Comment/commentMain.dart';
import 'package:provider/provider.dart';
import '../Pages/profilePage.dart';

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
    if (context.watch<HomeData>().homeData.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: context.watch<HomeData>().homeData.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Text(
                      context.watch<HomeData>().homeData[index]['username'],
                      style: Theme.of(context).textTheme.titleLarge),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                profileImage: context
                                    .watch<HomeData>()
                                    .homeData[index]['photoUrl'],
                                user: context.watch<HomeData>().homeData[index]
                                    ['username'])));
                  },
                ),
                context
                            .watch<HomeData>()
                            .homeData[index]['photoUrl']
                            .runtimeType ==
                        String
                    ? Image.network(
                        context.watch<HomeData>().homeData[index]['photoUrl'])
                    : Image.file(
                        context.watch<HomeData>().homeData[index]['photoUrl']),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasData) {
                              final snap = snapshot.data!.docs[index].data();
                              return TextButton.icon(
                                onPressed: () {
                                  context.read<HomeData>().pressLike(
                                      snap['postId'],
                                      snap['uid'],
                                      snap['likes']);
                                },
                                label: Text(
                                  snap["likes"].length.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                icon: snap["likes"]
                                        .contains(snap['uid'] ?? '유저없음')
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border,
                                        color: Colors.grey),
                              );
                            }
                            return const SizedBox();
                          }),
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
                                .doc(context.watch<HomeData>().homeData[index]
                                    ['postId'])
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
                                      style:
                                          const TextStyle(color: Colors.black),
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
                Text(context.watch<HomeData>().homeData[index]['description']),
                isChatOpen
                    ? CommentMain(
                        postId: context.watch<HomeData>().homeData[index]
                            ['postId'])
                    : const SizedBox()
              ],
            );
          });
    }
    return const SizedBox();
  }
}
