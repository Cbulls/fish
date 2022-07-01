import 'package:flutter/material.dart';
import 'package:instagram/Methods/homeMethods.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({Key? key, required this.postId}) : super(key: key);

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
                    return null;
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
                final isValid = _formKey.currentState!.validate();
                final read =  context.read<LoginSignupData>();
                if (isValid) {
                  _formKey.currentState!.save();
                  context.read<HomeData>().uploadComment(
                        read.authentication.currentUser?.uid,
                        widget.postId,
                        _commentController.text,
                        read.authentication.currentUser?.displayName,
                        read.authentication.currentUser?.photoURL,
                      );
                  setState(() {
                    _commentController.text = "";
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
