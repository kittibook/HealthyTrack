import 'package:app/components/mobile_layout.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/components/web_laout.dart';
import 'package:app/screen/login/login_from.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      webChild: WebLayout(
        imageWidget: Image.asset(
          'assets/images/1.png',
          width: 200,
          
        ),
        dataWidget: LoginForm(),
      ),
      mobileChild: MobileLayout(
        dataWidget: LoginForm(),
        imageWidget: Image.asset(
          'assets/images/1.png',
          width: 100,
        ),
      ),
    );
  }
}
