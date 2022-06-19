import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Methods/loginSignupMethods.dart';
import '../Methods/profileMethods.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.profileImage, this.user}) : super(key: key);
  final profileImage;
  final user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState(){
    super.initState();
    context.read<ProfileData>().getProfileImgData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text(widget.user),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 10, bottom : 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    foregroundImage: widget.profileImage != null ?
                    context.read<ProfileData>().putImage(widget.profileImage) :
                    context.read<ProfileData>().imageInProfile,
                  ),
                  Text(widget.user, style: const TextStyle(
                    fontSize: 20
                  ),),
                  IconButton(
                    color: context.watch<ProfileData>().isFollow ? Colors.red : Colors.grey,
                    onPressed: (){
                      context.read<ProfileData>().follow();
                      context.read<LoginSignupData>().signOut();
                      },
                    icon: const Icon(Icons.favorite)
                  )
                ],
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Image.network(
                      context.watch<ProfileData>().imageListInProfile[index]
                  ),
              childCount: context.watch<ProfileData>().imageListInProfile.length,
            ),
          ),
        ],
      )
    );
  }
}


