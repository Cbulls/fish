import 'package:flutter/material.dart';
import 'package:instagram/Widgets/appBar.dart';
import 'package:instagram/Widgets/searchbar.dart';

class PageData extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  returnAppBar() {
    if (currentIndex == 1) {
      return const Searchbar();
    } else {
      return TopAppBar();
    }
  }
}
