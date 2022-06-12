import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignupData extends ChangeNotifier{
  final authentication = FirebaseAuth.instance;

  bool isSignup = true;
  bool isSignupValid = false;
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String nameError = 'Please enter at least 4 characters';
  String emailError = 'Please enter a valid email address.';
  String passwordError = 'Password must be at least 7 characters long.';

  changeBool(status){
    isSignup = status;
    notifyListeners();
  }

  signIn() async{
    await authentication.signInWithEmailAndPassword(
        email: userEmail, password: userPassword
    );
    notifyListeners();
  }

  tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      isSignupValid = true;
      notifyListeners();
    }
    notifyListeners();
  }

  makeIsSignupValidFalse(status){
    isSignupValid = status;
    notifyListeners();
  }

  changeTextData(textValue, value){
    switch(textValue){
      case 'password':
        userPassword = value;
        break;
      case 'username':
        userName = value;
        break;
      case 'email':
        userEmail = value;
        break;
    }
  }

  validate(value, textValue){
    switch(textValue){
      case 'password':
        if (value!.isEmpty || value.length < 6) {
          print('password : $value');
          return 'Password must be at least 7 characters long.';
        }
        return null;
      case 'username':
        if (value!.isEmpty || value.length < 4) {
          print('username : $value');
          return 'Please enter at least 4 characters';
        }
        return null;
      case 'email':
        if (value!.isEmpty ||
            !value.contains('@')) {
          return 'Please enter a valid email address.';
        }
        return null;
      default:
        print('textValue : $textValue');
    }
    return null;
  }

  returnIcon(textValue){
    switch(textValue){
      case 'username':
        return Icons.account_box;
      case 'password':
        return Icons.lock;
      case 'email':
        return Icons.email;
    }
  }

  returnDecoration(textValue){
        return InputDecoration(
            prefixIcon: Icon(
              returnIcon(textValue),
              color: Colors.green,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blueGrey),
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.lightBlue),
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
            ),
            hintText: textValue,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black),
            contentPadding: const EdgeInsets.all(10),
            // errorText: validate(userPassword, 'password')
        );

  }
}