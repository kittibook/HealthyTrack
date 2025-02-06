import 'package:app/app_router.dart';
import 'package:app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

var initialRoute;

void main() async {
  // ต้องเรียกใช้ WidgetsFlutterBinding.ensureInitialized()
  // เพื่อให้สามารถเรียกใช้ SharedPreferences ได้
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
  FlutterNativeSplash.remove();
}
-
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
