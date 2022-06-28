import 'package:flutter/material.dart';
import 'package:instagram/Methods/homeMethods.dart';
import 'package:instagram/Methods/pageMethods.dart';
import 'package:instagram/Methods/profileMethods.dart';
import 'package:instagram/Methods/loginSignupMethods.dart';
import 'package:instagram/Widgets/sidebar.dart';
import 'package:instagram/widgets/bottomBar.dart';
// 그냥 style 변수는 다른 style 변수가 생겨 겹칠 수도 있어서 as theme을 만든다
import 'package:instagram/Widgets/notification.dart';
import 'package:instagram/constants/theme.dart' as theme;
import 'package:instagram/Pages/bodyPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/firebase_options.dart';

// 변수를 다른 파일에서 쓰기 싫을 때 : _변수 _함수명 _클래스명

void main() async {
  // 플러터에서 사용하는 플러그인을 초기화하는 메소드가 비동기 방식이면 문제가 난다. 왜냐면 runApp이 불러온 다음에야 접근을 할 수 있기 때문이다.
  // 따라서 플러터 코어 엔진을 초기화하기 위해서는 WidgetsFlutterBinding.ensureInitialized(); 코드를 실행해야한다
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeData>(create: (context) => HomeData()),
      ChangeNotifierProvider<ProfileData>(create: (context) => ProfileData()),
      ChangeNotifierProvider<LoginSignupData>(
          create: (context) => LoginSignupData()),
      ChangeNotifierProvider<PageData>(create: (context) => PageData())
    ],
    child: MaterialApp(
      theme: theme.style,
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    ),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<HomeData>().getPostData();
    context.read<LoginSignupData>().getUserInfo();
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: context.watch<PageData>().returnAppBar(),
        body: const BodyPage(),
        bottomNavigationBar: const BottomBar(),
        extendBodyBehindAppBar: true,
        endDrawer: const Sidebar(),
      ),
    );
  }
}
