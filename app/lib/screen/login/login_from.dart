import 'dart:convert';
import 'package:app/app_router.dart';
import 'package:app/components/custom_textfield.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/services/rest_api.dart';
import 'package:app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  // LoginForm({super.key});

  final _formKeyLogin = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "เข้าสู่ระบบ",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              key: _formKeyLogin,
              child: Column(children: [
                customTextField(
                  controller: _usernameController,
                  hintText: "username",
                  prefixIcon: const Icon(Icons.account_circle),
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกชื่อผู้ใช้";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่าน";
                    } else if (value.length < 6) {
                      return "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        //Open Forgot password screen here
                      },
                      child: const Text("ลืมรหัสผ่าน ?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238),
                    fontWeight: FontWeight.bold,
                  ),),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                    label: "LOGIN",
                    onPressed: () async {
                      // Navigator.pushReplacementNamed(context, AppRouter.home);
                      if (_formKeyLogin.currentState!.validate()) {
                        _formKeyLogin.currentState!.save();
                        var response = await CallAPI().loginAPI({
                          "username": _usernameController.text,
                          "password": _passwordController.text
                        });
                        var body = jsonDecode(response);
                        if (body['successfull'] == 'fail') {
                          // แจ้งเตือนว่าไม่มีการเชื่อมต่อ Internet
                          Utility.showAlertDialog(
                              context,
                              body['successfull'],
                              body['message']['title'],
                              body['message']['text']);
                        } else {
                          if (body['successfull'] == 'success') {
                            // บันทึกข้อมูลลงในตัวแปร SharedPreferences
                            await Utility.setSharedPreference(
                                'loginStatus', true);
                            await Utility.setSharedPreference(
                                'token', body["token"]["access_token"]);
                            // แจ้งเตือนว่าลงทะเบียนสำเร็จ
                            await Utility.showAlertDialog(
                              context,
                              body['successfull'],
                              body['message']['title'],
                              body['message']['text'],
                            );
                            Navigator.pushReplacementNamed(
                                context, AppRouter.home);
                          } else {
                            // แจ้งเตือนว่าลงทะเบียนไม่สำเร็จ
                            Utility.showAlertDialog(
                                context,
                                body['successfull'],
                                body['message']['title'],
                                body['message']['text']);
                          }
                        }
                        // Navigator.pushReplacementNamed(context, AppRouter.shoppingcart);
                      }
                    })
              ])),
          const SizedBox(
            height: 10,
          ),
          // const SocialMediaOptions(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ยังไม่มีบัญชีกับเรา ? ",style: TextStyle(
                    color: Color.fromARGB(255, 178, 130, 40),
                    fontWeight: FontWeight.bold,
                  ),),
              InkWell(
                onTap: () {
                  //Open Sign up screen here
                  Navigator.pushNamed(context, AppRouter.register);
                },
                child: const Text(
                  "สมัคร",
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
