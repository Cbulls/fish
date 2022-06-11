import 'package:flutter/material.dart';
import 'package:instagram/Store/homeData.dart';
import 'package:instagram/Store/profileData.dart';
import 'package:instagram/Store/loginSignupData.dart';
import 'package:instagram/widgets/bottomBar.dart';
// 그냥 style 변수는 다른 style 변수가 생겨 겹칠 수도 있어서 as theme을 만든다
import 'Widgets/notification.dart';
import 'constants/theme.dart' as theme;
import 'Pages/bodyPage.dart';
import 'widgets/appBar.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 변수를 다른 파일에서 쓰기 싫을 때 : _변수 _함수명 _클래스명

void main() async{
  // 플러터에서 사용하는 플러그인을 초기화하는 메소드가 비동기 방식이면 문제가 난다. 왜냐면 runApp이 불러온 다음에야 접근을 할 수 있기 때문이다.
  // 따라서 플러터 코어 엔진을 초기화하기 위해서는 WidgetsFlutterBinding.ensureInitialized(); 코드를 실행해야한다
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeData>(create: (context)=>HomeData()),
          ChangeNotifierProvider<ProfileData>(create: (context)=>ProfileData()),
          ChangeNotifierProvider<LoginSignupData>(create: (context)=>LoginSignupData()),
        ],
        child: MaterialApp(
          theme: theme.style,
          home: const MyApp(),
          debugShowCheckedModeBanner: false,
        ),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  var scrollController = ScrollController();

  void _changePage(int index){
    setState(()=>{
      _currentIndex = index
    });
  }

  @override
  void initState(){
    super.initState();
    context.read<HomeData>().getData();
    initNotification();
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TopAppBar(),
        body: BodyPage(
          changePage : _changePage,
          pageController : _pageController,
          currentIndex : _currentIndex,
        ),
        bottomNavigationBar: BottomBar(currentIndex: _currentIndex, pageController: _pageController),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
