import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';

class LoginSignupTap extends StatelessWidget {
  const LoginSignupTap({Key? key, required this.text}) : super(key: key);
  final String text;

  changeTapColor(text, bool value) {
    if (text == 'LOG IN') {
      if (!value) {
        return Colors.amber;
      } else {
        return Colors.grey;
      }
    }
    if (text == 'SIGN UP') {
      if (value) {
        return Colors.amber;
      } else {
        return Colors.grey;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<LoginSignupData>();
    final watch = context.watch<LoginSignupData>();
    return GestureDetector(
      onTap: () {
        text == 'LOG IN' ? read.changeBool(false) : read.changeBool(true);
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: changeTapColor(text, watch.isSignup),
            ),
          ),
          if (text == 'LOG IN' ? !watch.isSignup : watch.isSignup)
            Container(
              margin: const EdgeInsets.only(top: 3),
              height: 2,
              width: 55,
              color: Colors.orange,
            )
        ],
      ),
    );
  }
}
