import 'package:flutter/material.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';
import 'package:provider/provider.dart';
import 'package:instagram/Pages/loginSignupPage.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('user : ${context.read<LoginSignupData>().userData}');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Row(
              children: <Widget>[
                context.read<LoginSignupData>().userData != null
                    ? Text(context.read<LoginSignupData>().userData.username)
                    : TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginSignup()));
                        },
                        child: const Text(
                          '로그인',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
              ],
            ),
            //),
            accountEmail: const Text(''),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/batfish.jpg'),
                  fit: BoxFit.cover,
                )),
            currentAccountPicture:
                context.read<LoginSignupData>().userData != null
                    ? CircleAvatar(
                        foregroundImage: NetworkImage(
                            context.read<LoginSignupData>().userData.photoUrl),
                      )
                    : const CircleAvatar(
                        foregroundImage: AssetImage('assets/face.jpg'),
                      ),
          ),
          context.read<LoginSignupData>().userData != null
              ? ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text('로그아웃',
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                  onTap: () {
                    context.read<LoginSignupData>().signOut();
                  })
              : ListTile(
                  leading: const Icon(
                    Icons.login,
                    color: Colors.black,
                  ),
                  title: const Text('로그인',
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginSignup()));
                  })
        ],
      ),
    );
  }
}
