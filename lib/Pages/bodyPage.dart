import 'package:flutter/material.dart';
import '../widgets/homeItem.dart';

class BodyPage extends StatelessWidget {
  const BodyPage({Key? key,
    this.changePage,
    this.currentIndex,
    this.pageController,
  }) : super(key: key);

  final pageController;
  final changePage;
  final currentIndex;


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        HomeItem(),
        Center(
          child: Text('2'),
        ),
        Center(
          child: Text('3'),
        ),
        Center(
          child: Text('4'),
        ),
      ],
      onPageChanged: (int index){
        changePage(index);
      },
    );
  }
}
