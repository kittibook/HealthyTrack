import 'dart:async';

import 'package:app/services/rest_api.dart';
import 'package:app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamController<Map<String, dynamic>> _stepCountStreamController;
  late Stream<StepCount> _stepCountStream;
  double _kal = 0, _distance = 0, percent = 0.0, eat = 0.0, percenteat = 0.0, activity2 = 0.0;
  int _steps = 0;
  late Timer _dailyResetTimer;
  @override
  void initState() {
    super.initState();
    _stepCountStreamController = StreamController<Map<String, dynamic>>();
    get();
    checkPermissions().then((_) {
      initPlatformState();
    });
    _startDailyResetTimer();
  }

  Future<void> checkPermissions() async {
    var status = await Permission.activityRecognition.status;
    if (status.isDenied) {
      await Permission.activityRecognition.request();
    }
  }

  @override
  void dispose() {
    _dailyResetTimer.cancel();
    _stepCountStreamController.close();
    super.dispose();
  }

  void onStepCount(StepCount event) async {
    // คำนวณแคลอรี่
    double kcal = (event.steps * 0.05); // แปลงเป็น int โดยประมาณแคลอรี่
    double percent1 = (kcal / 120).clamp(0.02, 1.0);

    // สมมติว่า 1 step = 0.0008 กิโลเมตร (หรือคุณสามารถปรับสูตรตามที่คุณต้องการ)
    double distance = (event.steps * 0.0008); // คำนวณระยะทาง

    setState(() {
      _steps = event.steps; // ตั้งค่า _steps เป็นจำนวนก้าว
      _kal = kcal + activity2; // ตั้งค่า _kal เป็นแคลอรี่
      _distance = distance; // ตั้งค่า _distance เป็นระยะทาง\
      percent = percent1;
    });

    // _stepCountStreamController.add(data);
  }

  void _startDailyResetTimer() {
    _dailyResetTimer =
        Timer.periodic(const Duration(minutes: 1), (timer) async {
      await _checkAndResetDailySteps();
    });
  }

  // เช็กว่าวันเปลี่ยนหรือยัง ถ้าเปลี่ยนแล้วให้รีเซ็ตข้อมูล
  Future<void> _checkAndResetDailySteps() async {
    String? lastDate =
        Utility.getSharedPreference('last_reset_date'); // ดึงวันที่รีเซ็ตล่าสุด
    String today = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // วันที่ปัจจุบัน (YYYY-MM-DD)

    if (lastDate != today) {
      // ถ้าวันเปลี่ยนไปจากวันล่าสุดที่รีเซ็ต
      await saveData(); // บันทึกข้อมูลก่อนรีเซ็ต
      await Utility.setSharedPreference('Kcal $lastDate', 0.0);
      await Utility.setSharedPreference(
          'last_reset_date', today); // อัปเดตวันล่าสุดที่รีเซ็ต
      setState(() {
        _steps = 0;
        _kal = 0;
        _distance = 0;
        percent = 0.0;
      });
    }
  }

  saveData() async {
    // walkcount: string; kcal: string 
    await CallAPI().BHome({
      "walkcount" : _steps,
      "kcal" : _kal,
    });
  }

  get() async {
    String? lastDate = Utility.getSharedPreference('last_reset_date');
    int activity = await Utility.getSharedPreference('activity')?? 0;
    double kkal = 0.0;
    double activity1 = 0.0;
    int arm2cal = 0;
    int arm2steps = 0; 
    activity1 = (activity / 1000);
    kkal = await Utility.getSharedPreference('Kcal $lastDate') ?? 0.0;
    double percent1 = (kkal / 100).clamp(0.02, 1.0);

    setState(() {
      _steps = arm2steps + _steps;
        _kal = arm2cal + _kal ;
      eat = kkal;
      activity2 = activity1;
      percenteat = percent1;
    });

  }

  void onStepCountError(error) {
    setState(() {
      _steps = 0;
    });
  }

  Future<void> initPlatformState() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

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
                      // Text(
                      //   "วันอังคาร ที่ 7",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 16,
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200 * 0.60,
                      child: Image.asset('assets/images/1.png'),

                      // child: Image.asset('assets/images/app1.png'),
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
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // จัดข้อความให้ชิดซ้าย
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "การเคลื่อนไหว",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8), // ระยะห่างระหว่างข้อความ
                        Text(
                          "${_kal.toStringAsFixed(2)} / 120 กิโลแคล",
                          style: const TextStyle(
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
                      percent: percent,
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
                  _buildStatCard("จำนวนก้าว", _steps.toString(),
                      "วันนี้", const Color.fromARGB(255, 161, 78, 175)),
                  // การ์ดระยะทาง
                _buildStatCard("ระยะทางก้าว", '${_distance.toStringAsFixed(2)} กิโลเมตร',
                      "วันนี้", const Color.fromARGB(255, 102, 159, 206)),
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
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // จัดข้อความให้ชิดซ้าย
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // จัดข้อความให้ชิดซ้าย
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "การได้รับพลังงาน",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 8), // ระยะห่างระหว่างข้อความ
                                Text(
                                  "${eat.toStringAsFixed(2)} กิโลแคล",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 39, 183, 111),
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
                              percent: percenteat,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Color.fromARGB(255, 46, 183, 39),
                              backgroundColor: Color.fromARGB(255, 32, 100, 72),
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
