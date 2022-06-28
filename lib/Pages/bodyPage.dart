import 'package:flutter/material.dart';
import 'package:instagram/Methods/pageMethods.dart';
import 'package:instagram/Widgets/gridUsedItems.dart';
import 'package:provider/provider.dart';
import 'package:instagram/widgets/homeItem.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: context.read<PageData>().pageController,
      children: const [
        HomeItem(),
        GridUsedItems(),
        Center(
          child: Text('3'),
        ),
        Center(
          child: Text('4'),
        ),
      ],
      onPageChanged: (int index) {
        context.read<PageData>().changePage(index);
      },
    );
  }
}
