import 'package:flutter/material.dart';
import 'package:instagram/Methods/profileMethods.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';
//Todo 버튼 효과 : https://medium.flutterdevs.com/bouncing-button-animation-in-flutter-d0296442f3c5

class LoginSignupSendingButton extends StatelessWidget {
  const LoginSignupSendingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var read = context.read<LoginSignupData>();
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      top: context.watch<LoginSignupData>().isSignup ? 520 : 490,
      right: 0,
      left: 0,
      child: Center(
        child: context.watch<LoginSignupData>().isLoading
            ? const CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.all(15),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: GestureDetector(
                  onTap: () {
                    context.read<LoginSignupData>().changeIsLoading(true);
                    read.isSignup
                        ? read.signUp(
                            context, context.read<ProfileData>().profileImage)
                        : read.signIn(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
