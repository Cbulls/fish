import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/Widgets/LoginSignup/LoginSignupTextfield/signupProfileImage.dart';

class LoginSignupData extends ChangeNotifier{
  final authentication = FirebaseAuth.instance;

  bool isSignup = true;
  bool isSignupValid = true;
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

  signIn(BuildContext context) async{
    try {
      !isSignupValid ? isSignupValid = true : null;
      await authentication.signInWithEmailAndPassword(
          email: userEmail.trim(), password: userPassword.trim()
      );
    } on FirebaseAuthException catch (errorCode) {
      isSignupValid = false;
      print('isSignupValid : $isSignupValid');
      print('SignIn FirebaseAuthException : $errorCode');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(getMessageFromErrorCode(errorCode.code)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20),
        ),
      );
    }
    notifyListeners();
  }

  signOut()async{
    try{
      await authentication.signOut();
      isSignup = false;
    } on FirebaseAuthException catch(errorCode){
      print('SignOut FirebaseAuthException : $errorCode');
    }
    notifyListeners();
  }

  signUp(BuildContext context) async {
    try{
      !isSignupValid ? isSignupValid = true : null;
      UserCredential result = await authentication.createUserWithEmailAndPassword(
          email: userEmail.trim(), password: userPassword.trim()
      );
      await result.user!.updateDisplayName(userName);
    } on FirebaseAuthException catch (errorCode){
      isSignupValid = false;
      print('SignUp FirebaseAuthException : $errorCode.code');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(getMessageFromErrorCode(errorCode.code)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20),
        ),
      );
    }
    notifyListeners();
  }

  tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      isSignupValid = true;
    }
    notifyListeners();
  }

  changeTextData(textValue, value){
    switch(textValue){
      case 'password':
        userPassword = value!;
        break;
      case 'username':
        userName = value!;
        break;
      case 'email':
        userEmail = value!;
        break;
    }
  }


  changeProfileImage(){
    if(isSignup){
      return SignupProfileImage();
    }else{
      return Container();
    }
  }

  validate(value, textValue){
    switch(textValue){
      case 'password':
        if (value!.isEmpty || value.length < 6) {
          return 'Password must be at least 7 characters long.';
        }
        return null;
      case 'username':
        if (value!.isEmpty || value.length < 4) {
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

  returnNoProfileImage(){
    return ClipOval(
        child: Image.asset(
          'assets/face.jpg',
          height: 50.0,
          width: 50.0,
          fit: BoxFit.fill,
        ),
      );
  }

  returnProfileImage(imagePath){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.file(
        File(imagePath),
        height: 50.0,
        width: 50.0,
        fit: BoxFit.fill,
      ),
    );
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
      );
  }

  String getMessageFromErrorCode(errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }
}