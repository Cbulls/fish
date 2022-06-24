import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Methods/loginSignupMethods.dart';

class GoogleLoginSignupButton extends StatelessWidget {
  const GoogleLoginSignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      top: context.watch<LoginSignupData>().isSignup
          ? MediaQuery.of(context).size.height - 125
          : MediaQuery.of(context).size.height - 165,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Text(context.watch<LoginSignupData>().isSignup
              ? 'or Signup with'
              : 'or Signin with'),
          const SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: () {
              context.read<LoginSignupData>().signInWithGoogle(context);
            },
            style: TextButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(155, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: const Color.fromRGBO(207, 70, 51, 1)),
            icon: const Icon(Icons.add),
            label: const Text('Google'),
          ),
        ],
      ),
    );
  }
}
