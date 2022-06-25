import 'package:flutter/material.dart';
import 'package:instagram/Widgets/usedItemCard.dart';

class UsedItemsPage extends StatelessWidget {
  const UsedItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(10, (index) {
          return UsedItemCard();
          //   Center(
          //   child: Text(
          //     'Item $index',
          //     style: Theme.of(context).textTheme.headline5,
          //   ),
          // );
        }));
  }
}
