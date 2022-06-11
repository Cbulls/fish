import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Store/loginSignupData.dart';

class LoginSignupTextFormField extends StatelessWidget {
  const LoginSignupTextFormField({Key? key,
    required this.valueKeyNumb,
    required this.textValue})
  : super(key: key);

  final int valueKeyNumb;
  final String textValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: textValue == 'password' ? true : false,
      key: const ValueKey(3),
      validator: (value) {
        if (value!.isEmpty || value.length < 6) {
          return 'Password must be at least 7 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        context.watch<LoginSignupData>().userPassword = value!;
      },
      onChanged: (value) {
        context.watch<LoginSignupData>().userPassword = value;
      },
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.red,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blueGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          hintText: 'password',
          hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.red),
          contentPadding: EdgeInsets.all(10)),
    );
  }
}
