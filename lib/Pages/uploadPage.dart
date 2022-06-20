import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Methods/homeMethods.dart';
import '../Methods/profileMethods.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var textController = TextEditingController();
  var now = DateTime.now();
  final authentication = auth.FirebaseAuth.instance;
  List freshwaterFishList = [
    '민물고기 아님',
    '가물치',
    '누치',
    '배스',
    '붕어',
    '블루길',
    '잉어',
    '종류 미상'
  ];
  String _selectedFish = '민물고기 아님';

  void changeSelected(fish) {
    setState(() {
      _selectedFish = fish;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('이미지 업로드'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('업로드 날짜 : ${DateFormat('MMM dd').format(now)}'),
            DropdownButton(
              value: _selectedFish,
              items: freshwaterFishList.map((fish) {
                return DropdownMenuItem(
                  value: fish,
                  child: Text(fish),
                );
              }).toList(),
              onChanged: (fish) {
                setState(() {
                  _selectedFish = fish.toString();
                });
              },
            ),
            context
                .read<ProfileData>()
                .showImage(context.read<ProfileData>().uploadedImage),
            TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: '설명을 적어주세요~'),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
            StreamBuilder<auth.User?>(
                stream: context
                    .watch<LoginSignupData>()
                    .authentication
                    .authStateChanges(),
                builder: (context, snapshot) {
                  print('snapshot hasData : ${snapshot.hasData}');
                  return IconButton(
                    onPressed: () {
                      print(
                          'userData : ${context.read<LoginSignupData>().userData}');
                      // context.read<HomeData>().putData(
                      //       context.read<ProfileData>().uploadedImage,
                      //       textController.text,
                      //       now,
                      //     );
                      setState(() {
                        context.read<LoginSignupData>().isLoading = true;
                      });
                      context.read<HomeData>().uploadPost(
                          textController.text,
                          context
                              .read<LoginSignupData>()
                              .authentication
                              .currentUser!
                              .uid,
                          context.read<ProfileData>().uploadedImage,
                          context
                              .read<LoginSignupData>()
                              .authentication
                              .currentUser!
                              .displayName);
                      setState(() {
                        context.read<LoginSignupData>().isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.add),
                  );
                }),
            context.watch<LoginSignupData>().isLoading
                ? const CircularProgressIndicator()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
