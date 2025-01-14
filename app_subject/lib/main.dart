// กำหนดตัวแปร initialRoute ให้กับ MaterialApp
import 'package:app_subject/app_router.dart';
import 'package:app_subject/utils/utility.dart';
import 'package:flutter/material.dart';

var initialRoute;

void main() async {
  // ต้องเรียกใช้ WidgetsFlutterBinding.ensureInitialized()
  // เพื่อให้สามารถเรียกใช้ SharedPreferences ได้
  WidgetsFlutterBinding.ensureInitialized();

  // เรียกใช้ SharedPreferences
  await Utility.initSharedPrefs();
  

  // ตรวจสอบว่าเคยแสดง Intro แล้วหรือยัง
  if (Utility.getSharedPreference('loginStatus') == true) {
    // ถ้าเคยแสดง Intro แล้ว ให้ไปยังหน้า Login
    initialRoute = AppRouter.home;
  } else {
    // ถ้ายังไม่เคยแสดง Intro ให้ไปยังหน้า Welcome
    // initialRoute = AppRouter.welcome;
    initialRoute = AppRouter.login;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: AppRouter.route,
    );
  }
}
