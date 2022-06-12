import 'package:flutter/material.dart';
import 'package:instagram/Pages/login.dart';
import 'package:instagram/Widgets/notification.dart';
import 'package:provider/provider.dart';
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
    return AppBar(
      title: context.watch<LoginSignupData>().authentication.currentUser != null ?
        Text(context.watch<LoginSignupData>().authentication.currentUser.toString()) : Text('Instagram'),
      actions: [
        IconButton(onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LoginSignupScreen())
          );
        }, icon: const Icon(Icons.star),),
        IconButton(onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LoginSignup())
          );
        }, icon: const Icon(Icons.account_box),),
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
