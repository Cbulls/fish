import 'package:flutter/material.dart';

class UsedItemCard extends StatelessWidget {
  const UsedItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/puppy.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text('강아지'),
        Text('17만원'),
        Text('30')
      ],
    );
  }
}
