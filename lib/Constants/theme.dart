import 'package:flutter/material.dart';

// 요소 하나하나 마다 각각의 style code를 작성하면 코드가 길어지기 때문에 themedata를 쓴다.

var style = ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      color: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 15,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedIconTheme: IconThemeData(
      color: Colors.grey
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 10
    )
  )
);