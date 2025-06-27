import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schedule/controller/calendar_controller.dart';
import 'package:schedule/screen/calendar.dart';
import 'package:schedule/screen/list.dart';
import 'package:schedule/screen/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //flutter에서 모든 비동기 작업이면 해당 문장을 넣어줘야 함
  await Hive.initFlutter(); //hive 초기화
  await Hive.openBox('scheduleBox'); //문서 생성
  await Hive.openBox<String>('recentSearchBox');

  Get.put(SheduleConteroller()); //전역 State 불러오기
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'moonly',
      theme: ThemeData(
        textTheme: GoogleFonts.juaTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(171, 165, 220, 1),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      home: SplashScreen(), // 스플래시 화면을 첫 화면으로 설정
    );
  }
}

// SplashScreen 위젯 만들기
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 2초 후에 홈 화면으로 전환
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.gif'), // 로고 SVG 표시
            SizedBox(height: 20),
            Text(
              'moonly',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(171, 165, 220, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MainScreen (기존 MyApp의 화면)
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int seletedIndex = 0;

  void changeIndex(int idx) {
    setState(() {
      seletedIndex = idx;
    });
  }

  List<Widget> pageList = [CalendarPage(), Home(), Search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'moonly',
              style: TextStyle(
                color: Color.fromRGBO(171, 165, 220, 1),
                fontSize: 25,
              ),
            ),
            SizedBox(width: 3),
            SvgPicture.asset('assets/logo_moon.svg'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: pageList[seletedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: seletedIndex,
        selectedItemColor: Color.fromRGBO(163, 157, 208, 1),
        unselectedItemColor: Color.fromRGBO(205, 202, 223, 1),
        onTap: changeIndex, //굳이 인자값을 안보내줘도 알아서 idx값을 보내줌 왜? 몰라?..
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch_rounded),
            label: 'list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'search',
          ),
        ],
      ),
    );
  }
}
