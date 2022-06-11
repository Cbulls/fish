import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Store/loginSignupData.dart';

class LoginSignupTap extends StatelessWidget {
  const LoginSignupTap({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        text=='LOG IN' ? context.read<LoginSignupData>().changeBool(false) : context.read<LoginSignupData>().changeBool(true);
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: text=='LOG IN' ? Colors.brown : Colors.purple
            ),
          ),
          if (text=='LOG IN'? !context.watch<LoginSignupData>().isSignup : context.watch<LoginSignupData>().isSignup)
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
