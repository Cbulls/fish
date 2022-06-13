import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Store/loginSignupData.dart';
import '../../main.dart';

class LoginSignupSendingButton extends StatelessWidget {
  const LoginSignupSendingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      top: context.watch<LoginSignupData>().isSignup ? 520 : 470,
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
              print('isSignup : ${context.read<LoginSignupData>().isSignup}');
              context.read<LoginSignupData>().isSignup ?
                context.read<LoginSignupData>().signUp(context) : context.read<LoginSignupData>().signIn();
              final isValid = context.read<LoginSignupData>().formKey.currentState!.validate();
              if (isValid) {
                context.read<LoginSignupData>().formKey.currentState!.save();
                Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const MyApp()));
              }
            },
            // onTap: () async {
            //   if (context.watch<LoginSignupData>().isSignup) {
            //     context.watch<LoginSignupData>().tryValidation();
            //       // final isValid = context.read<LoginSignupData>().formKey.currentState!.validate();
            //       // if (isValid) {
            //       //   context.read<LoginSignupData>().formKey.currentState!.save();
            //       // }
            //     try {
            //       await  context.read<LoginSignupData>().authentication
            //           .createUserWithEmailAndPassword(
            //         email:  context.watch<LoginSignupData>().userEmail,
            //         password: context.watch<LoginSignupData>().userPassword,
            //       );
            //
            //       if (newUser.user != null) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) {
            //               return MyApp();
            //             },
            //           ),
            //         );
            //       }
            //     } catch (e) {
            //       print(e);
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content:
            //           Text('Please check your email and password'),
            //           backgroundColor: Colors.blue,
            //         ),
            //       );
            //     }
            //   }
            //   if (!context.watch<LoginSignupData>().isSignup) {
            //     // context.read<LoginSignupData>().tryValidation();
            //       final isValid = context.read<LoginSignupData>().formKey.currentState!.validate();
            //       if (isValid) {
            //         context.read<LoginSignupData>().formKey.currentState!.save();
            //         // Navigator.push(
            //         //             context, MaterialPageRoute(builder: (context) => const MyApp()));
            //       }
            //     try {
            //       final newUser =
            //       await context.read<LoginSignupData>().authentication.signInWithEmailAndPassword(
            //         email: context.watch<LoginSignupData>().userEmail,
            //         password: context.watch<LoginSignupData>().userPassword,
            //       );
            //       if (newUser.user != null) {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) {
            //               return MyApp();
            //             },
            //           ),
            //         );
            //       }
            //     }catch(e){
            //       print(e);
            //     }
            //   }
            // },
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
