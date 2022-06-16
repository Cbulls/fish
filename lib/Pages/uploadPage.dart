import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Store/homeData.dart';
import '../Store/profileData.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  var textController = TextEditingController();
  var now = DateTime.now();

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
              context.read<ProfileData>().showImage(
                context.read<ProfileData>().uploadedImage
              ),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                    hintText: '설명'
                ),
              ),
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)
              ),
              IconButton(
                onPressed: (){
                  context.read<HomeData>().putData(
                    context.read<ProfileData>().uploadedImage,
                    textController.text,
                    now
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add)
              ),
            ],
          ),
        )
    );
  }
}