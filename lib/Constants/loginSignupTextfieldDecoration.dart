import 'package:flutter/material.dart';

returnDecoration(textValue){
switch(textValue){
case 'password':
return const InputDecoration(
prefixIcon: Icon(
Icons.lock,
color: Colors.black,
),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.blueGrey),
borderRadius: BorderRadius.all(
Radius.circular(35.0),
),
),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.black),
borderRadius: BorderRadius.all(
Radius.circular(35.0),
),
),
hintText: 'password',
hintStyle: TextStyle(
fontSize: 14,
color: Colors.black),
contentPadding: EdgeInsets.all(10),
errorText: 'Password must be at least 7 characters long.'
);
case 'username':
return const InputDecoration(
prefixIcon: Icon(
Icons.account_box,
color: Colors.green,
),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.blueGrey),
borderRadius: BorderRadius.all(
Radius.circular(35.0),
),
),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.black),
borderRadius: BorderRadius.all(
Radius.circular(35.0),
),
),
hintText: 'username',
hintStyle: TextStyle(
fontSize: 14,
color: Colors.black),
contentPadding: EdgeInsets.all(10),
errorText: 'Password must be at least 7 characters long.'
);
case 'email':
return const InputDecoration(
prefixIcon: Icon(
Icons.email,
color: Colors.teal,
),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.blueGrey),
borderRadius: BorderRadius.all(
Radius.circular(35.0),
),
),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(
color: Colors.black),
borderRadius: BorderRadius.all(
Radius.circular(35.0),
),
),
hintText: 'email',
hintStyle: TextStyle(
fontSize: 14,
color: Colors.black),
contentPadding: EdgeInsets.all(10)
);
}
}
