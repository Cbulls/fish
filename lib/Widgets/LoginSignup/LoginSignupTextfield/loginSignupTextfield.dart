import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Store/loginSignupData.dart';
import './loginSignupTap.dart';

class LoginSignupTextfield extends StatelessWidget {
  const LoginSignupTextfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(20.0),
        height: context.watch<LoginSignupData>().isSignup ? 250.0 : 210.0,
        // width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 5),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  LoginSignupTap(text: 'LOG IN'),
                  LoginSignupTap(text: 'SIGN UP')
                ],
              ),
              if (context.watch<LoginSignupData>().isSignup)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    key:  context.watch<LoginSignupData>().formKey,
                    child: Column(
                      children: [
                        // TextFormField(
                        //   key: const ValueKey(1),
                        //   validator: (value) {
                        //     if (value!.isEmpty || value.length < 4) {
                        //       return 'Please enter at least 4 characters';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (value) {
                        //      context.watch<LoginSignupData>().userName = value!;
                        //   },
                        //   onChanged: (value) {
                        //      context.watch<LoginSignupData>().userName = value;
                        //   },
                        //   decoration: const InputDecoration(
                        //       prefixIcon: Icon(
                        //         Icons.account_circle,
                        //         color: Colors.purple,
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Colors.yellow),
                        //         borderRadius: BorderRadius.all(
                        //           Radius.circular(35.0),
                        //         ),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Colors.white),
                        //         borderRadius: BorderRadius.all(
                        //           Radius.circular(35.0),
                        //         ),
                        //       ),
                        //       hintText: 'User name',
                        //       hintStyle: TextStyle(
                        //           fontSize: 14,
                        //           color: Colors.black),
                        //       contentPadding: EdgeInsets.all(10)),
                        // ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: const ValueKey(2),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                             context.watch<LoginSignupData>().userEmail = value!;
                          },
                          onChanged: (value) {
                             context.watch<LoginSignupData>().userEmail = value;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'email',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black),
                              contentPadding: EdgeInsets.all(10)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          obscureText: true,
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
                        )
                      ],
                    ),
                  ),
                ),
              if (!context.watch<LoginSignupData>().isSignup)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Form(
                    key:  context.watch<LoginSignupData>().formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: const ValueKey(4),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                             context.watch<LoginSignupData>().userEmail = value!;
                          },
                          onChanged: (value) {
                             context.watch<LoginSignupData>().userEmail = value;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'email',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black),
                              contentPadding: EdgeInsets.all(10)),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          key: const ValueKey(5),
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
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
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
                                  color: Colors.black),
                              contentPadding: EdgeInsets.all(10)),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
