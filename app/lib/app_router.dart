
import 'package:app/screen/Home.dart';
import 'package:app/screen/botomnavbar/editprofile_screen.dart';
import 'package:app/screen/login/login_sreen.dart';
import 'package:app/screen/menu/Arm_1.dart';
import 'package:app/screen/menu/Arm_2.dart';
import 'package:app/screen/menu/Book_1.dart';
import 'package:app/screen/menu/Book_1_1.dart';
import 'package:app/screen/menu/Book_2.dart';
import 'package:app/screen/menu/Save_1.dart';
import 'package:app/screen/menu/Save_2.dart';
import 'package:app/screen/register/register_sreen.dart';

class AppRouter {
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String menubook = 'menubook';
  static const String menubook1 = 'menubook1';
  static const String menubook2 = 'menubook2';
  static const String menusave = 'menusave';
  static const String menusave2 = 'menusave2';
  static const String menuarm = 'menuarm';
  static const String menuarm2 = 'menuarm2';
  static const String editprofile = 'editprofile';

  static get route => {
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        home: (context) => const NAV(),
        menubook: (context) => const Book1(),
        menubook1: (context) => const Book11(),
        menubook2: (context) => const Book2(),
        menusave: (context) => const Save1(),
        menusave2: (context) => const Save2(),
        menuarm: (context) => const Arm1(),
        menuarm2: (context) => const Arm2(),
        editprofile: (context) => const EditprofileScreen(),
        

      };
}