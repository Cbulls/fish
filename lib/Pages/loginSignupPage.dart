import 'package:flutter/material.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';
import 'package:instagram/Widgets/LoginSignup/googleLoginSignupButton.dart';
import 'package:instagram/Widgets/LoginSignup/loginSignupSendingButton.dart';
import 'package:instagram/Widgets/LoginSignup/loginSignupBackground.dart';
import 'package:instagram/Widgets/LoginSignup/LoginSignupTextfield/loginSignupTextfield.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Widgets/LoginSignup/LoginSignupTextfield/signupProfileImage.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 바닥을 다시 측정해서 키보드 자판 올라가는거 방지
        resizeToAvoidBottomInset: false,
        // body를 appBar 뒤로 배치시켜서 appBar를 투명하게 만든다.
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
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
              //프로필 이미지
              context.watch<LoginSignupData>().isSignup
                  ? const SignupProfileImage()
                  : const SizedBox(),
              //텍스트 폼 필드
              LoginSignupTextfield(),
              //전송버튼
              context.read<LoginSignupData>().isLoading
                  ? const Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue)),
                      ),
                    )
                  : const LoginSignupSendingButton(),
              //구글 로그인 버튼
              const GoogleLoginSignupButton(),
            ],
          ),
        ));
  }
}
