import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Pages/login.dart';
import 'package:instagram/Widgets/notification.dart';
import 'package:provider/provider.dart';
import '../Pages/profilePage.dart';
import '../Pages/uploadPage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Pages/loginSignupPage.dart';
import '../Store/loginSignupData.dart';

class TopAppBar extends StatefulWidget with PreferredSizeWidget{
  TopAppBar({Key? key, this.uploadData}) : super(key: key);
  final uploadData;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  var selectedImage;

  @override
  Widget build(BuildContext context) {
    print('appbar userName : ${context.watch<LoginSignupData>().authentication.currentUser}');
    return AppBar(
      title: context.watch<LoginSignupData>().authentication.currentUser?.displayName != null ?
        Text(context.watch<LoginSignupData>().authentication.currentUser!.displayName.toString()) :
      const Text('Instagram'),
      actions: [
        IconButton(onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LoginSignupScreen())
          );
        }, icon: const Icon(Icons.star),),
        StreamBuilder<User?>(
            stream: context.watch<LoginSignupData>().authentication.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return IconButton(onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) =>
                      Profile(
                        profileImage: snapshot.data?.photoURL ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Jordan_Lipofsky.jpg/180px-Jordan_Lipofsky.jpg',
                        // user: snapshot.data!.displayName,
                        user: snapshot.data?.displayName ?? 'fdasadf',
                      ))
                );
              }, icon: const Icon(Icons.star),);
            }else{
              return IconButton(onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LoginSignup())
                );
              }, icon: const Icon(Icons.account_box),);
            }
          }
        ),
        IconButton(onPressed: (){showNotification();}, icon: const Icon(Icons.notification_add),),
        IconButton(
            onPressed: () async{
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if(image != null) {
                setState(() {
                  selectedImage = File(image.path);
                });
              }
              if (!mounted) return;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Upload(image: selectedImage, uploadData: widget.uploadData,))
              );
            },
            icon: const Icon(Icons.add_box_outlined)
        )
      ],
    );
  }
}
