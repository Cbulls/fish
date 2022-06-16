import 'package:flutter/material.dart';
import 'package:instagram/Store/profileData.dart';
import 'package:provider/provider.dart';
import '../../Store/loginSignupData.dart';

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
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)),
          child: GestureDetector(
            onTap: (){
              read.isSignup ? read.signUp(context, context.read<ProfileData>().profileImage) : read.signIn(context);
              final isValid = read.formKey.currentState!.validate();
              if (isValid && read.isSignupValid) {
                read.formKey.currentState!.save();
              }
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
