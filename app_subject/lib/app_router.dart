import 'package:app_subject/screen/Home.dart';
import 'package:app_subject/screen/login/login_sreen.dart';
import 'package:app_subject/screen/menu/Arm_1.dart';
import 'package:app_subject/screen/menu/Arm_2.dart';
import 'package:app_subject/screen/menu/Book_1.dart';
import 'package:app_subject/screen/menu/Book_2.dart';
import 'package:app_subject/screen/menu/Save_1.dart';
import 'package:app_subject/screen/menu/Save_2.dart';
import 'package:app_subject/screen/register/register_sreen.dart';

class AppRouter {
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String menubook = 'menubook';
  static const String menubook2 = 'menubook2';
  static const String menusave = 'menusave';
  static const String menusave2 = 'menusave2';
  static const String menuarm = 'menuarm';
  static const String menuarm2 = 'menuarm2';

  static get route => {
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        home: (context) => const NAV(),
        menubook: (context) => const Book1(),
        menubook2: (context) => const Book2(),
        menusave: (context) => const Save1(),
        menusave2: (context) => const Save2(),
        menuarm: (context) => const Arm1(),
        menuarm2: (context) => const Arm2(),
        

      };
}