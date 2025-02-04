import 'dart:convert';

import 'package:app/app_router.dart';
import 'package:app/components/rounded_button.dart';
import 'package:app/services/rest_api.dart';
import 'package:app/utils/utility.dart';
import 'package:flutter/material.dart';

class ProfileScreenBottomnav extends StatefulWidget {
  const ProfileScreenBottomnav({super.key});

  @override
  State<ProfileScreenBottomnav> createState() => _ProfileScreenBottomnavState();
}

class _ProfileScreenBottomnavState extends State<ProfileScreenBottomnav> {
  String? _name, _day, _h, _w, _bmi, _age, _Waist, _bmidetail;

  getProfile() async {
  try {
    var response = await CallAPI().getUserProfileAPI();
    var body = jsonDecode(response);
    if (body != null && body is Map<String, dynamic>) {
      setState(() {
        _name = body['name'] ?? 'ไม่มีข้อมูล';
        _day = body['birthday'] ?? 'ไม่ระบุวันเกิด';
        _age = body['age']?.toString() ?? '0';
        _h = body['height']?.toString() ?? '0';
        _w = body['weight']?.toString() ?? '0';
        _Waist = body['Waist'] ?? 'ไม่มีข้อมูล';
        _bmi = body['bmi']?.toString()  ?? 'ไม่มีข้อมูล';
        _bmidetail = body['bmi_detail'] ?? 'ไม่มีข้อมูล';
      });
    }
  } catch (e) {
    // จัดการข้อผิดพลาด
    Utility().logger.e("เกิดข้อผิดพลาด: $e");
  }
}


  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: SizedBox(
                        width: double.infinity,
                        height: 200 * 0.60,
                        child: Image.asset('assets/images/1.png'),
                    
                    // child: Image.asset('assets/images/app1.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 50, 50, 50),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "ชื่อ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                 _name ?? 'ไม่มีข้อมูล',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "อายุ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                _age ?? 'ไม่มีข้อมูล',
                                style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "ปี",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "วันเกิด",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                 _day ?? 'ไม่พบข้อมูล',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "ส่วนสูง",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                _h ?? 'ไม่พบข้อมูล',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "ซม.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "น้ำหนัก",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                _w ?? 'ไม่พบข้อมูล',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "กก.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "BMI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                _bmi ?? "ไม่พบข้อมูล",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: RoundedButton(
                            label: "แก้ไขโปรไฟลฺ์",
                            onPressed: () async {
                               Navigator.pushNamed(context, AppRouter.editprofile);
                            }
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 20.0),
              // Center(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 200,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: const Color.fromARGB(255, 50, 50, 50),
              //     ),
              //     child: const Column(
              //       crossAxisAlignment:
              //           CrossAxisAlignment.center, // จัดข้อความให้ชิดซ้าย
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           "ผลการตรวจ",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //           ),
              //         ),
              //         SizedBox(height: 10), // ระยะห่างระหว่างข้อความ
              //         Text(
              //           "ผลการตรวจอยู่ในเกณฑ์ป่วยระดับ 1",
              //           style: TextStyle(
              //             color: Color.fromARGB(255, 206, 209, 27),
              //             fontSize: 22,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            const SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 50, 50, 50),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // จัดข้อความให้ชิดซ้าย
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "คำแนะนำ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // ระยะห่างระหว่างข้อความ
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _bmidetail ?? "",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 244, 244, 244),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
