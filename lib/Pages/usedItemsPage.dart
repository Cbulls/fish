import 'package:flutter/material.dart';
import 'package:instagram/Widgets/usedItemCard.dart';

class UsedItemsPage extends StatelessWidget {
  const UsedItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return const UsedItemCard();
        }));
  }
}
