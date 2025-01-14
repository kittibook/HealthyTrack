import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนหัว
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "สรุป",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "วันอังคาร ที่ 7",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // วงกลมแสดงข้อมูลการเคลื่อนไหว
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 50, 50, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // จัดระยะห่างระหว่างองค์ประกอบ
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // จัดข้อความให้ชิดซ้าย
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "การเคลื่อนไหว",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8), // ระยะห่างระหว่างข้อความ
                        Text(
                          "120/120 กิโลแคล",
                          style: TextStyle(
                            color: Color.fromARGB(255, 183, 48, 39),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    new CircularPercentIndicator(
                      radius: 70.0,
                      lineWidth: 25.0,
                      animation: true,
                      percent: 0.8,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color.fromARGB(255, 183, 48, 39),
                      backgroundColor: Color.fromARGB(255, 100, 37, 32),
                    ),


                    // Container(
                    //   width: 150,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(500),
                    //     border: Border.all(
                    //       width: 20,
                    //       color: const Color.fromARGB(255, 183, 48, 39),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // การ์ดจำนวนก้าว
                  _buildStatCard("จำนวนก้าว", "4,321", "วันนี้",
                      const Color.fromARGB(255, 161, 78, 175)),
                  // การ์ดระยะทาง
                  _buildStatCard("ระยะทางก้าว", "3.21 กม.", "วันนี้",
                      const Color.fromARGB(255, 102, 159, 206)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 50, 50, 50),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // จัดข้อความให้ชิดซ้าย
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ผลการตรวจ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10), // ระยะห่างระหว่างข้อความ
                    Text(
                      "ผลการตรวจอยู่ในเกณฑ์ป่วยระดับ 1",
                      style: TextStyle(
                        color: Color.fromARGB(255, 206, 209, 27),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatCard(
    String title, String value, String subtitle, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 50, 50, 50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
                color: color, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // จัดให้กราฟกระจาย
            children: [
              // แต่ละแท่งกราฟ
              Container(
                width: 10,
                height: 50,
                color: color,
              ),
              Container(
                width: 10,
                height: 40,
                color: color,
              ),
              Container(
                width: 10,
                height: 60,
                color: color,
              ),
              Container(
                width: 10,
                height: 45,
                color: color,
              ),
              Container(
                width: 10,
                height: 55,
                color: color,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
