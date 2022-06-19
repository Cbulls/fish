import 'dart:io';
import 'package:flutter/material.dart';

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
      'assets/face.jpeg',
      height: 50.0,
      width: 50.0,
      fit: BoxFit.fill,
    ),
  );
}

returnProfileImage(image){
  print('return : $image');
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Image.file(
      File(image.path),
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

returnSnackBar(context, errorCode){
  return SnackBar(
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
  );
}
