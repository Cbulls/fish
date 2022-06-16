import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Store/profileData.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Store/loginSignupData.dart';

class SignupProfileImage extends StatefulWidget {
  SignupProfileImage({Key? key}) : super(key: key);

  @override
  State<SignupProfileImage> createState() => _SignupProfileImageState();
}

class _SignupProfileImageState extends State<SignupProfileImage> {
  var selectedImage;

  uploadProfileImage () async{
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (!mounted) return;
    if(image != null) {
      setState(() {
        selectedImage = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 140,
        left: MediaQuery.of(context).size.width*0.5 - 50,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              context.watch<ProfileData>().profileImage != null ?
              context.read<LoginSignupData>().returnProfileImage(context.read<ProfileData>().profileImage) :
              context.read<LoginSignupData>().returnNoProfileImage(),
              Positioned(
                  bottom: -5,
                  left: 0,
                  right: -50,
                  child: RawMaterialButton(
                    onPressed: (){
                      // uploadProfileImage();
                      context.read<ProfileData>().uploadImage(context, 'out');
                    },
                    elevation: 2.0,
                    fillColor: const Color(0xFFF5F6F9),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                  )
              ),
            ],
          ),
        )
    );
  }
}
