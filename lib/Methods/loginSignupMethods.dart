import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram/Methods/profileMethods.dart';
import 'package:provider/provider.dart';
import '../Constants/loginSignupConstants.dart';
import './storageMethod.dart';
import '../Models/users.dart';

class LoginSignupData extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final authentication = FirebaseAuth.instance;
  bool isSignup = true;
  bool isSignupValid = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  var userData;

  getUserInfo() async {
    var currentUser = authentication.currentUser!;
    var userSnapshot =
        await firestore.collection('users').doc(currentUser.uid).get();
    print('photoURL : ${ModelUser.fromSnap(userSnapshot).photoUrl}');
    userData = ModelUser.fromSnap(userSnapshot);
    notifyListeners();
  }

  changeIsLoading(status) {
    isLoading = status;
    notifyListeners();
  }

  changeBool(status) {
    isSignup = status;
    notifyListeners();
  }

  signIn(BuildContext context) async {
    try {
      final navigator = Navigator.of(context);
      final read = context.read<ProfileData>();
      !isSignupValid ? isSignupValid = true : null;
      await authentication.signInWithEmailAndPassword(
          email: userEmail.trim(), password: userPassword.trim());
      Future.delayed(
        const Duration(seconds: 3),
      );
      read.profileImage = null;
      navigator.pop();
    } on FirebaseAuthException catch (errorCode) {
      isSignupValid = false;
      print('SignIn FirebaseAuthException : $errorCode');
      ScaffoldMessenger.of(context)
          .showSnackBar(returnSnackBar(context, errorCode));
    }
    isLoading = false;
    getUserInfo();
    notifyListeners();
  }

  signOut() async {
    try {
      await authentication.signOut();
      isSignup = false;
    } on FirebaseAuthException catch (errorCode) {
      print('SignOut FirebaseAuthException : $errorCode');
    }
    isLoading = false;
    notifyListeners();
  }

  signUp(BuildContext context, image) async {
    // final readUserData = context.read<UserData>();
    try {
      final navigator = Navigator.of(context);
      !isSignupValid ? isSignupValid = true : null;
      UserCredential result =
          await authentication.createUserWithEmailAndPassword(
        // trim 공백 제거
        email: userEmail.trim(),
        password: userPassword.trim(),
      );
      String photoUrl = await uploadImageToStorage('profilePics', image, false);
      if (isSignupValid) {
        ModelUser user = ModelUser(
          username: userName,
          uid: result.user!.uid,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );
        // adding user in our database
        await firestore
            .collection("users")
            .doc(result.user!.uid)
            .set(user.toJson());
      }
      await result.user!.updateDisplayName(userName);
      await result.user!.updatePhotoURL(photoUrl);
      // 회원가입 성공 후 종료
      navigator.pop();
    } on FirebaseAuthException catch (errorCode) {
      isSignupValid = false;
      print('SignUp FirebaseAuthException : $errorCode.code');
      ScaffoldMessenger.of(context)
          .showSnackBar(returnSnackBar(context, errorCode));
    }
    isLoading = false;
    getUserInfo();
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    Navigator.pop(context);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  changeTextData(textValue, value) {
    switch (textValue) {
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
}
