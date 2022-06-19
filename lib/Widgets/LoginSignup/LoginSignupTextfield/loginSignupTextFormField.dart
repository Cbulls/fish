import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Methods/loginSignupMethods.dart';
import '../../../Constants/loginSignupConstants.dart';

class LoginSignupTextFormField extends StatelessWidget {
  const LoginSignupTextFormField({Key? key,
    required this.valueKeyNumb,
    required this.textValue})
  : super(key: key);

  final int valueKeyNumb;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    var read = context.read<LoginSignupData>();
    switch(textValue){
      case 'password':
        return TextFormField(
          obscureText: true,
          validator: (value){
            if (value!.isEmpty || value.length < 6) {
              return 'Password must be at least 7 characters long.';
            }
            return null;
          },
          key: ValueKey(valueKeyNumb),
          onSaved: (value) {
            read.changeTextData(textValue, value);
          },
          onChanged: (value) {
            read.changeTextData(textValue, value);
          },
          decoration: returnDecoration(textValue),
        );
      case 'username':
        return TextFormField(
          validator: (value){
            if (value!.isEmpty || value.length < 4) {
              return 'Please enter at least 4 characters';
            }
            return null;
          },
          key: ValueKey(valueKeyNumb),
          onSaved: (value) {
            read.changeTextData(textValue, value);
          },
          onChanged: (value) {
            read.changeTextData(textValue, value);
          },
          decoration: returnDecoration(textValue),
        );
      case 'email':
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value){
            if (value!.isEmpty ||
                !value.contains('@')) {
              return 'Please enter a valid email address.';
            }
            return null;
          },
          key: ValueKey(valueKeyNumb),
          onSaved: (value) {
            read.changeTextData(textValue, value);
          },
          onChanged: (value) {
            read.changeTextData(textValue, value);
          },
          decoration: returnDecoration(textValue),
        );
    }
    return Container();
  }
}
