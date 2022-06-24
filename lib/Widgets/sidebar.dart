import 'package:flutter/material.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/bass.png'),
                fit: BoxFit.cover,
              )),
              child: Stack(children: const <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 5.0,
                    child: Text(
                      "설정",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w500),
                    )),
              ])),
          ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text('로그아웃',
                  style: TextStyle(fontSize: 17, color: Colors.black)),
              onTap: () {
                context.read<LoginSignupData>().signOut();
              })
        ],
      ),
    );
  }
}
