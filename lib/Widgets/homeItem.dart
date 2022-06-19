import 'package:flutter/material.dart';
import 'package:instagram/Methods/homeMethods.dart';
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
  void initState(){
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && countAPI < 1){
        context.read<HomeData>().getMoreData();
        countAPI++;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if (context.watch<HomeData>().homeData.isNotEmpty) {
      return ListView.builder(itemCount: context.watch<HomeData>().homeData.length, controller: scrollController, itemBuilder: (context, index){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.watch<HomeData>().homeData[index]['image'].runtimeType == String? Image.network(context.watch<HomeData>().homeData[index]['image']) :
            Image.file(context.watch<HomeData>().homeData[index]['image']),
            Text('Likes ${context.watch<HomeData>().homeData[index]['likes']}'),
            GestureDetector(
              child: Text(context.watch<HomeData>().homeData[index]['user']),
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                    Profile(profileImage : context.watch<HomeData>().homeData[index]['image'], user: context.watch<HomeData>().homeData[index]['user'])
                ));
              },
            ),
            Text(context.watch<HomeData>().homeData[index]['content'])
          ],
        );
      });
    }
    return const SizedBox();
  }
}
