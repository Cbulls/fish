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

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          countAPI < 1) {
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
                      child: TextButton.icon(
                        onPressed: () {
                          context.read<HomeData>().pressLike(
                              context.read<HomeData>().homeData[index]
                                  ['postId'],
                              context.read<HomeData>().homeData[index]['uid'],
                              context.read<HomeData>().homeData[index]
                                  ['likes']);
                        },
                        label: Text(context
                            .watch<HomeData>()
                            .homeData[index]['likes']
                            .length
                            .toString()),
                        icon: const Icon(Icons.favorite),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      label: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .doc(context.watch<HomeData>().homeData[index]
                                  ['postId'])
                              .collection('comments')
                              .orderBy('createdAt', descending: false)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            return snapshot.hasData
                                ? Text(snapshot.data!.docs.length.toString())
                                : const Text('0');
                          }),
                      icon: const Icon(
                        Icons.chat,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Text(
                      context.watch<HomeData>().homeData[index]['username']),
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
                Text(context.watch<HomeData>().homeData[index]['description']),
                CommentMain(
                    postId: context.watch<HomeData>().homeData[index]['postId'])
              ],
            );
          });
    }
    return const SizedBox();
  }
}
