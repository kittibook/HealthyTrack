import 'dart:convert';

import 'package:app_subject/app_router.dart';
import 'package:app_subject/components/custom_textfield.dart';
import 'package:app_subject/components/rounded_button.dart';
import 'package:app_subject/services/rest_api.dart';
import 'package:app_subject/utils/utility.dart';
import 'package:flutter/material.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _fromKeyRegister = GlobalKey<FormState>();

  String Age = '';
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _age1Controller = TextEditingController();
  // final _brithController = TextEditingController();
  final _higthController = TextEditingController();
  final _weightController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordsubmitController = TextEditingController();
  final _addnewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "สมัครสมาชิก",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _fromKeyRegister,
            child: Column(
              children: [
                customTextField(
                  controller: _nameController,
                  hintText: 'ชื่อ - นามสกุล',
                  prefixIcon: const Icon(Icons.account_circle),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'วันเกิด วว/ดด/ปป ',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    filled: true,
                    isDense: true,
                    prefixIconColor: Colors.black,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกวันเกิด';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    List<String> dateParts = value.split('/');
                    if (dateParts.length == 3) {
                      // กำหนดตัวแปรสำหรับวัน เดือน ปี
                      String y = dateParts[2];

                      int year = 2567;

                      if (y.isNotEmpty) {
                        year = int.parse(y);
                      }
                      // แปลงปีเป็น int

                      // คำนวณอายุ
                      int age = 2567 - year;
                      String agestring = age.toString();
                      setState(() {
                        Age = agestring;
                        _age1Controller.text = 'อายุ $agestring ปี';
                      });
                    }
                  },
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.grey[300],
                //     borderRadius: BorderRadius.circular(40)
                //   ),
                //   child: SizedBox(
                //     width: 400,
                //     height: 50,
                //     child: Row(
                //       children: [
                //         const Padding(
                //           padding: EdgeInsets.only(top: 0.0, left: 30.0),
                //           child: Text('อายุ', style: TextStyle(fontSize: 20, color: Colors.grey),),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                //           child: Text(Age, style: TextStyle(fontSize: 20, color: Colors.grey[600]),),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _age1Controller,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'อายุ ',
                    prefixIcon: const Icon(Icons.event_available),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    filled: true,
                    isDense: true,
                    prefixIconColor: Colors.black,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // customTextField(
                //   controller: _brithController,
                //   hintText: 'วันเกิด วว/ดด/ปป ',
                //   prefixIcon: const Icon(Icons.calendar_today),
                //   obscureText: false,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'กรุณากรอกวันเกิด';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                customTextField(
                  controller: _weightController,
                  hintText: 'น้ำหนัก',
                  prefixIcon: const Icon(Icons.accessibility),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกน้ำหนัก';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextField(
                  controller: _higthController,
                  hintText: 'ส่วนสูง',
                  prefixIcon: const Icon(Icons.boy),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกส่วนสูง';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextField(
                  controller: _addnewController,
                  hintText: 'รอบเอว ( CM ) ',
                  prefixIcon: const Icon(Icons.attribution),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกรอบเอว';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextField(
                  controller: _usernameController,
                  hintText: 'ชื่อผู้ใช้',
                  prefixIcon: const Icon(Icons.perm_identity),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อผู้ใช้';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextField(
                  controller: _passwordController,
                  hintText: 'รหัสผ่าน',
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
                  height: 30,
                ),
                customTextField(
                  controller: _passwordsubmitController,
                  hintText: 'รหัสผ่านยืนยัน',
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณากรอกรหัสผ่าน";
                    } else if (value.length < 6) {
                      return "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัวอักษร";
                    } else if (value != _passwordController.text) {
                      return "รหัสผ่านใม่ตรงกัน";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  label: 'สมัครสมาชิก',
                  onPressed: () async {
                    // ตรวจสอบข้อมูลฟอร์ม
                    if (_fromKeyRegister.currentState!.validate()) {
                      // ถ้าข้อมูลผ่านการตรวจสอบ ให้ทำการบันทึกข้อมูล
                      _fromKeyRegister.currentState!.save();

                      // Navigator.pushNamed(context, AppRouter.login);
                      // แสดงข้อมูลที่บันทึกใน Console
                      // print("username: ${_usernameController.text}");
                      // print("Password: ${_nameController.text}");

                      // เรียกใช้งาน API สำหรับลงทะเบียน Register
                      var response = await CallAPI().registerAPI({
                        "username": _usernameController.text,
                        "password": _passwordController.text,
                        "passwordconfirm": _passwordsubmitController.text,
                        "name": _nameController.text,
                        "age": Age,
                        "birthday": _ageController.text,
                        "height": _higthController.text,
                        "weight": _weightController.text,
                        "Waist": _addnewController.text,
                      });
                      var body = jsonDecode(response);
                      Utility().logger.i(response);
                      await Utility.showAlertDialog(
                        context,
                        body['successfull'],
                        body['message']['title'],
                        body['message']['text'],
                      );
                      if (body['successfull'] == 'success') {
                        Navigator.pushReplacementNamed(
                            context, AppRouter.login);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}