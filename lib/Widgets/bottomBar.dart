import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Methods/pageMethods.dart';

final _bottomBarList = [
  const BottomNavigationBarItem(
    label: 'Home',
    icon: Icon(Icons.home),
  ),
  const BottomNavigationBarItem(
    label: 'Shop',
    icon: Icon(Icons.shopping_bag),
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
  const BottomBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: context.watch<PageData>().currentIndex,
      items: _bottomBarList,
      onTap: (index) {
        context.read<PageData>().pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }
}
