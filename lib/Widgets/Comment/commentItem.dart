import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, this.snapshot}) : super(key: key);

  final snapshot;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot['photoUrl']),
              radius: 20,
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Row(
            children: [
              Text(snapshot['username']),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(snapshot['comment']),
              ),
            ],
          )
        ],
      ),
    );
  }
}
