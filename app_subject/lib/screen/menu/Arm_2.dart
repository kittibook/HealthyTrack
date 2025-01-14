import 'dart:async';

import 'package:flutter/material.dart';

class Arm2 extends StatefulWidget {
  const Arm2({super.key});

  @override
  State<Arm2> createState() => _Arm2State();
}

class _Arm2State extends State<Arm2> {
  bool _isRunning = false; // สถานะของการทำกิจกรรม
  String fixedDate = '13/7/2025'; // วันที่คงที่
  double caloriesBurned = 150.0; // แคลอรี่ที่เผาผลาญ
  int walkingSteps = 1200; // จำนวนก้าวที่เดิน

  int _elapsedTime = 0; // เวลาในวินาทีที่ผ่านไป
  late Timer _timer; // ตัวจัดการ Timer

  void _startOrStopTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });

    if (_isRunning) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _elapsedTime = 0;
    });
    _stopTimer();
  }

  String _formatTime(int seconds) {
    int hours = (seconds / 3600).floor(); // คำนวณจำนวนชั่วโมง
    int minutes = ((seconds % 3600) / 60).floor(); // คำนวณจำนวน "นาที" ที่เหลือ
    int remainingSeconds = seconds % 60; // คำนวณจำนวน "วินาที" ที่เหลือ

    // รูปแบบเวลาที่แสดง
    return '$hours ชั่วโมง $minutes นาที';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ติดตามการบิณฑบาต',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // แสดงวัน, เวลา และแคลอรี่ที่เผาผลาญ
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 36),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '$fixedDate',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    'แคลอรี่ที่เผาผลาญ',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$caloriesBurned',
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'KCAL',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ก้าวและเวลาเป็น Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container สำหรับเดินจงกรม
                Container(
                  width: 160,
                  height: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[800], // สีเทาอ่อน
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.directions_walk,
                          color: Colors.yellow,
                          size: 40.0,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$walkingSteps ก้าว',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container สำหรับนั่งสมาธิ
                Container(
                  width: 160,
                  height: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[800], // สีเทาอ่อน
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.self_improvement,
                          color: Colors.green,
                          size: 40.0,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formatTime(_elapsedTime),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 150),
            // เพิ่มปุ่มใน Column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ปุ่มเริ่ม
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30), // เพิ่ม padding ซ้ายขวา
                  child: SizedBox(
                    width: double.infinity, // ใช้ให้ปุ่มเต็มความกว้าง
                    child: ElevatedButton(
                      onPressed: _startOrStopTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRunning ? Colors.red : Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _isRunning ? 'หยุด' : 'เริ่ม',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // ปุ่มเริ่มใหม่
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30), // เพิ่ม padding ซ้ายขวา
                  child: SizedBox(
                    width: double.infinity, // ใช้ให้ปุ่มเต็มความกว้าง
                    child: ElevatedButton(
                      onPressed: _resetTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text("บันทึกและเริ่มใหม่",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
