import 'package:flutter/material.dart';

final _bottomBarList = [
  const BottomNavigationBarItem(
    label: 'Home',
    icon: Icon(Icons.home),
  ),
  const BottomNavigationBarItem(
    label: 'Music',
    icon: Icon(Icons.music_note),
  ),
  const BottomNavigationBarItem(
    label: 'Places',
    icon: Icon(Icons.location_on),
  ),
  const BottomNavigationBarItem(
    label: 'News',
    icon: Icon(Icons.library_books),
  ),
];


class BottomBar extends StatelessWidget {
  const BottomBar({Key? key,
    this.currentIndex,
    this.pageController}) : super(key: key);
  final currentIndex;
  final pageController;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: _bottomBarList,
      onTap: (index){
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease
        );
      },
    );
  }
}

