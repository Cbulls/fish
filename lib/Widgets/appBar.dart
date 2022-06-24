import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:instagram/Pages/login.dart';
import 'package:instagram/Methods/profileMethods.dart';
// import 'package:instagram/Widgets/notification.dart';
import 'package:provider/provider.dart';
import '../Pages/profilePage.dart';
import '../Pages/loginSignupPage.dart';
import '../Methods/loginSignupMethods.dart';

class TopAppBar extends StatefulWidget with PreferredSizeWidget {
  TopAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  var selectedImage;

  @override
  Widget build(BuildContext context) {
    print(
        'appbar userName : ${context.watch<LoginSignupData>().authentication.currentUser}');
    return StreamBuilder<User?>(
      stream:
          context.watch<LoginSignupData>().authentication.authStateChanges(),
      builder: (context, snapshot) {
        return AppBar(
          title: snapshot.hasData
              ? Text(context
                  .watch<LoginSignupData>()
                  .authentication
                  .currentUser!
                  .displayName
                  .toString())
              : const Text('Instagram'),
          actions: [
            snapshot.hasData
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            profileImage: snapshot.data!.photoURL ??
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Jordan_Lipofsky.jpg/180px-Jordan_Lipofsky.jpg',
                            user: snapshot.data!.displayName ?? '이름없음',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.star),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginSignup()));
                    },
                    icon: const Icon(Icons.account_circle),
                  ),
            IconButton(
                onPressed: () {
                  context.read<ProfileData>().uploadImage(context, 'upload');
                },
                icon: const Icon(Icons.upload)),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            )
          ],
        );
      },
    );
  }
}
