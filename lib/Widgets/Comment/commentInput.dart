import 'package:flutter/material.dart';
import 'package:instagram/Methods/homeMethods.dart';
import 'package:provider/provider.dart';

import '../../Methods/loginSignupMethods.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({Key? key, required this.snapshot, required this.postId})
      : super(key: key);

  final snapshot;
  final postId;
  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 55.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  validator: (input) {
                    if (input == null) {
                      return "Please enter comment";
                    }
                  },
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: "Add a comment...",
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: const Text('Post', style: TextStyle(color: Colors.blue)),
              ),
              onTap: () {
                print('widget : ${widget.snapshot.data}');
                final isValid = _formKey.currentState!
                    .validate(); // Null check operator used on a null value
                if (isValid) {
                  _formKey.currentState!.save();
                  print(
                      'userData : ${context.read<LoginSignupData>().userData}');
                  context.read<HomeData>().uploadComment(
                      // widget.snapshot.uid,
                      // widget.postId,
                      // _commentController.text,
                      // widget.snapshot.username,
                      // widget.snapshot.photoUrl
                      context.read<LoginSignupData>().userData.uid,
                      widget.postId,
                      _commentController.text,
                      context.read<LoginSignupData>().userData.username,
                      context.read<LoginSignupData>().userData.photoUrl);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}