import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';

class LoginSignupBackground extends StatelessWidget {
  const LoginSignupBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/lonelyBoat.jpg'), fit: BoxFit.fill),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 90, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Welcome',
                  style: const TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 25,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: context.watch<LoginSignupData>().isSignup ? ' to fish gram!' : ' back',
                      style: const TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                context.watch<LoginSignupData>().isSignup
                    ? 'Signup to continue'
                    : 'Signin to continue',
                style: const TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
