import 'package:flutter/material.dart';
import 'package:instagram/Widgets/LoginSignup/LoginSignupTextfield/loginSignupTextFormField.dart';
import 'package:provider/provider.dart';
import '../../../Methods/loginSignupMethods.dart';
import './loginSignupTap.dart';

class LoginSignupTextfield extends StatelessWidget {
  LoginSignupTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(20.0),
        height: context.watch<LoginSignupData>().isSignup ? 280.0 : 230.0,
        // width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  LoginSignupTap(text: 'LOG IN'),
                  LoginSignupTap(text: 'SIGN UP')
                ],
              ),
              if (context.watch<LoginSignupData>().isSignup)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key:  context.watch<LoginSignupData>().formKey,
                    child: Column(
                      children: [
                        LoginSignupTextFormField(valueKeyNumb: 1, textValue: 'username'),
                        const SizedBox(
                          height: 8,
                        ),
                        LoginSignupTextFormField(valueKeyNumb: 2, textValue: 'email'),
                        const SizedBox(
                          height: 8,
                        ),
                        LoginSignupTextFormField(valueKeyNumb: 3, textValue: 'password')
                      ],
                    ),
                  ),
                ),
              if (!context.watch<LoginSignupData>().isSignup)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key:  context.watch<LoginSignupData>().formKey,
                    //key: formKey,
                    child: Column(
                      children: [
                        LoginSignupTextFormField(valueKeyNumb: 4, textValue: 'email'),
                        const SizedBox(
                          height: 8.0,
                        ),
                        LoginSignupTextFormField(valueKeyNumb: 5, textValue: 'password')
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
