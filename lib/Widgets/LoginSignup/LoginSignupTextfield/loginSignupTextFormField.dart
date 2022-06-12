import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Store/loginSignupData.dart';

class LoginSignupTextFormField extends StatelessWidget {
  LoginSignupTextFormField({Key? key,
    required this.valueKeyNumb,
    required this.textValue})
  : super(key: key);

  final int valueKeyNumb;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    switch(textValue){
      case 'password':
        return TextFormField(
          obscureText: true,
          validator: (value){
            if (value!.isEmpty || value.length < 6) {
              print('password : $value');
              return 'Password must be at least 7 characters long.';
            }
            return null;
          },
          key: ValueKey(valueKeyNumb),
          onSaved: (value) {
            context.read<LoginSignupData>().changeTextData(textValue, value);
          },
          onChanged: (value) {
            context.read<LoginSignupData>().changeTextData(textValue, value);
          },
          decoration: context.read<LoginSignupData>().returnDecoration(textValue),
        );
      case 'username':
        return TextFormField(
          validator: (value){
            if (value!.isEmpty || value.length < 4) {
              print('username : $value');
              return 'Please enter at least 4 characters';
            }
            return null;
          },
          key: ValueKey(valueKeyNumb),
          onSaved: (value) {
            context.read<LoginSignupData>().changeTextData(textValue, value);
          },
          onChanged: (value) {
            context.read<LoginSignupData>().changeTextData(textValue, value);
          },
          decoration: context.read<LoginSignupData>().returnDecoration(textValue),
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
            context.read<LoginSignupData>().changeTextData(textValue, value);
          },
          onChanged: (value) {
            context.read<LoginSignupData>().changeTextData(textValue, value);
          },
          decoration: context.read<LoginSignupData>().returnDecoration(textValue),
        );
    }
    return Container();
  }
}
