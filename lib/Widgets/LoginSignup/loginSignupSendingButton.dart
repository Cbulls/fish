import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Store/loginSignupData.dart';

class LoginSignupSendingButton extends StatelessWidget {
  const LoginSignupSendingButton({Key? key}) : super(key: key);

   //error
  @override
  Widget build(BuildContext context) {
    var read = context.read<LoginSignupData>();
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      top: read.isSignup ? 520 : 490,
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
            onTap: () {
              print('isSignup : ${read.isSignup}');
              read.isSignup ? read.signUp(context) : read.signIn(context);
              final isValid = read.formKey.currentState!.validate();
              if (isValid && read.isSignupValid) {
                read.formKey.currentState!.save();
              }
              // isSignupValid가 false로 바뀌기 전에 동작하는 것을 막기 위해 텀을 준다.
              Future.delayed(const Duration(milliseconds : 1000),() {
                if(read.isSignupValid){
                  print('isSignupValid : ${read.isSignupValid}');
                  Navigator.pop(context);
                }
              });
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
