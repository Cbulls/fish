import 'package:flutter/material.dart';
import 'package:instagram/Methods/profileMethods.dart';
import 'package:provider/provider.dart';
import '../../../Constants/loginSignupConstants.dart';

class SignupProfileImage extends StatelessWidget {
  const SignupProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 140,
        left: MediaQuery.of(context).size.width * 0.5 - 50,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              context.watch<ProfileData>().profileImage != null
                  ? returnProfileImage(context.read<ProfileData>().profileImage)
                  : returnNoProfileImage(),
              Positioned(
                  bottom: -5,
                  left: 0,
                  right: -50,
                  child: RawMaterialButton(
                    onPressed: () {
                      // uploadProfileImage();
                      context.read<ProfileData>().uploadImage(context, 'out');
                    },
                    elevation: 2.0,
                    fillColor: const Color(0xFFF5F6F9),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                    ),
                  )),
            ],
          ),
        ));
  }
}
