import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/Pages/profilePage.dart';
import 'package:instagram/Store/loginSignupData.dart';
import 'package:instagram/Widgets/LoginSignup/loginSignupSendingButton.dart';
import 'package:instagram/Widgets/LoginSignup/loginSignupBackground.dart';
import 'package:instagram/Widgets/LoginSignup/LoginSignupTextfield/loginSignupTextfield.dart';
import 'package:provider/provider.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 바닥을 다시 측정해서 키보드 자판 올라가는거 방지
      resizeToAvoidBottomInset : false,
      // body를 appBar 뒤로 배치시켜서 appBar를 투명하게 만든다.
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue,
      body: GestureDetector(
              onTap: () {
                // 키보드가 화면에 올라왔을 때 다른곳을 누르면 다시 내려가는 기능
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  //배경
                  const LoginSignupBackground(),
                  //텍스트 폼 필드
                  LoginSignupTextfield(),
                  //전송버튼
                  LoginSignupSendingButton(),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: context
                        .watch<LoginSignupData>()
                        .isSignup
                        ? MediaQuery
                        .of(context)
                        .size
                        .height - 125
                        : MediaQuery
                        .of(context)
                        .size
                        .height - 165,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Text(context
                            .watch<LoginSignupData>()
                            .isSignup ? 'or Signup with' : 'or Signin with'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: const Size(155, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.black),
                          icon: const Icon(Icons.add),
                          label: const Text('Google'),
                        ),
                      ],
                    ),
                  ),
                  //구글 로그인 버튼
                ],
              ),
            )
    );
  }
}