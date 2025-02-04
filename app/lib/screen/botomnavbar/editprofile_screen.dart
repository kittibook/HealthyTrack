import 'package:app/app_router.dart';
import 'package:app/components/custom_textfield.dart';
import 'package:app/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final _formKeyProfile = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'แก้ไขโปรไฟล์',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // ทำให้ข้อความอยู่กลาง
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 50, 50, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    key: _formKeyProfile,
                    child: Form(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, bottom: 5.0),
                                child: Text(
                                  "ชื่อ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 171, 171),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TEXTF(
                                controller: _nameController,
                                hintText: "ชื่อ",
                                prefixIcon: const Icon(Icons.account_circle),
                                obscureText: false,
                                textInputType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(255)
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกชื่อ';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, bottom: 5.0),
                                child: Text(
                                  "อายุ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 171, 171),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TEXTF(
                                controller: _ageController,
                                hintText: "อายุ",
                                prefixIcon: const Icon(Icons.event),
                                obscureText: false,
                                textInputType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(255)
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกอายุ';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, bottom: 5.0),
                                child: Text(
                                  "วันเกิด",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 171, 171),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TEXTF(
                                controller: _birthdayController,
                                hintText: "วันเกิด",
                                prefixIcon: const Icon(Icons.calendar_month),
                                obscureText: false,
                                textInputType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(255)
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกวันเกิด';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, bottom: 5.0),
                                child: Text(
                                  "ส่วนสูง",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 171, 171),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TEXTF(
                                controller: _heightController,
                                hintText: "ส่วนสูง",
                                prefixIcon: const Icon(Icons.height),
                                obscureText: false,
                                textInputType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(255)
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกส่วนสูง';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, bottom: 5.0),
                                child: Text(
                                  "น้ำหนัก",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 171, 171),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TEXTF(
                                controller: _weightController,
                                hintText: "น้ำหนัก",
                                prefixIcon: const Icon(Icons.monitor_weight),
                                obscureText: false,
                                textInputType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(255)
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกน้ำหนัก';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: RoundedButton(
                                label: "ยืนยันการแก้ไขโปรไฟล์",
                                onPressed: () async {
                                  Navigator.pushNamed(
                                      context, AppRouter.editprofile);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
