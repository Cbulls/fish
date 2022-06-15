import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Store/loginSignupData.dart';

class SignupProfileImage extends StatefulWidget {
  SignupProfileImage({Key? key}) : super(key: key);

  @override
  State<SignupProfileImage> createState() => _SignupProfileImageState();
}

class _SignupProfileImageState extends State<SignupProfileImage> {
  bool isUploadImage = false;
  var selectedImage;

  uploadProfileImage () async{
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      setState(() {
        selectedImage = image.path;
      });
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 140,
        left: MediaQuery.of(context).size.width*0.5 - 50,
        // left: 0,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              isUploadImage && selectedImage != null ? context.read<LoginSignupData>().returnProfileImage(selectedImage) :
              context.watch<LoginSignupData>().returnNoProfileImage(),
              Positioned(
                  bottom: -5,
                  left: 0,
                  right: -50,
                  child: RawMaterialButton(
                    onPressed: () {
                      uploadProfileImage();
                      setState(() {
                        isUploadImage = true;
                      });
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
