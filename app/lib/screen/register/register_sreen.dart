import 'package:app/components/mobile_layout.dart';
import 'package:app/components/responsive_layout.dart';
import 'package:app/components/web_laout.dart';
import 'package:app/screen/register/register_from.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      webChild: WebLayout(
        imageWidget: Image.asset(
          'assets/images/1.png',
          width: 200,
        ),
        dataWidget: RegisterForm(),
      ),
      mobileChild: MobileLayout(
        dataWidget: RegisterForm(),
        imageWidget: Image.asset(
          'assets/images/1.png',
          width: 100,
        ),
      ),
    );
  }
}