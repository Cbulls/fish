import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignupData extends ChangeNotifier{
  final authentication = FirebaseAuth.instance;

  bool isSignup = true;
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  changeBool(status){
    isSignup = status;
    notifyListeners();
  }

  tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      notifyListeners();
    }
  }
}