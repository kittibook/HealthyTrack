import 'dart:async';
import 'package:app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/services/rest_api.dart';

class Arm2 extends StatefulWidget {
  const Arm2({super.key});

  @override
  State<Arm2> createState() => _Arm2State();
}

class _Arm2State extends State<Arm2> {
  bool _isRunning = false;
  String dateString = "05/02/2568";
  String caloriesBurned = "0.00";
  double walkingSteps = 0.0;
  int _steps = 0, cal = 0;

  int _elapsedTime = 0;
  Timer? _timer;

  int _h = 0;
  int _m = 0;

  StreamSubscription<StepCount>? _pedometerSubscription;

  @override
  void initState() {
    super.initState();
    checkPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateDate());
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadArm2());
  }

  Future<void> checkPermissions() async {
    var status = await Permission.activityRecognition.status;

    if (status.isDenied) {
      await Permission.activityRecognition.request();
    }
  }

  void _saveArm2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('elapsedTime', _elapsedTime);
    prefs.setInt('walkingSteps', walkingSteps.toInt());
    prefs.setString('caloriesBurned', caloriesBurned);
  }

  void _loadArm2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _elapsedTime = prefs.getInt('elapsedTime') ?? 0;
      walkingSteps = prefs.getInt('walkingSteps')?.toDouble() ?? 0.0;
      caloriesBurned = prefs.getString('caloriesBurned') ?? "0.00";
    });
  }

  void _startPedometer() {
    _pedometerSubscription?.cancel();
    _pedometerSubscription = Pedometer.stepCountStream.listen((event) {
      if (_isRunning) {
        setState(() {
          walkingSteps += event.steps.toDouble();
          caloriesBurned = (0.05 * walkingSteps).toStringAsFixed(2);
        });
      }
    });
  }

  void _updateDate() {
    DateTime now = DateTime.now();
    int buddhistYear = now.year + 543;

    setState(() {
      dateString = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/$buddhistYear";
    });
  }

  void _startOrStopTimer() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        walkingSteps = 0;
        _startPedometer();
        _startTimer();
      } else {
        _stopTimer();
        _pedometerSubscription?.cancel();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
        _saveArm2();
      });
    });
  }

  void _stopTimer() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }

  Future<void> _resetTimer() async {

    setState(() {
      _isRunning = false;
      _showTimeSavedDialog();
      _elapsedTime = 0;
      caloriesBurned = "0.00";
      walkingSteps = 0.0;
    });
    _saveArm2();
    _stopTimer();
  }

  String _formatTime(int seconds) {
    int hours = (seconds / 3600).floor();
    int minutes = ((seconds % 3600) / 60).floor();
    return '$hours ชม. $minutes นาที ${seconds % 60} วิ';
  }

  @override
  void dispose() {
    _pedometerSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  void _showTimeSavedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("เวลาถูกบันทึกแล้ว",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey[800],
          content: const Text("คุณได้ทำกิจกรรมสมาธิเสร็จสิ้นแล้ว",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await CallAPI()
                    .saveDbTime({"type": "3", "timeh": "$_h", "timem": "$_m"});
              },
              child: const Text("ตกลง",
                  style: TextStyle(color: Colors.green, fontSize: 18)),
            ),
          ],
        );
      },
    );
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
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 36),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(dateString,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 10),
                  const Text('แคลอรี่ที่เผาผลาญ',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 20),
                  Text('$caloriesBurned',
                      style:
                          const TextStyle(fontSize: 30, color: Colors.white)),
                  const SizedBox(height: 20),
                  const Text('KCAL',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoCard(Icons.directions_walk, Colors.yellow,
                    "${walkingSteps.toStringAsFixed(0)} ก้าว"),
                _buildInfoCard(Icons.self_improvement, Colors.green,
                    _formatTime(_elapsedTime)),
              ],
            ),
            const SizedBox(height: 150),
            _buildButton(_isRunning ? "หยุด" : "เริ่ม", _startOrStopTimer,
                _isRunning ? Colors.red : Colors.green),
            const SizedBox(height: 20),
            _buildButton("บันทึกและเริ่มใหม่", _resetTimer, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, Color iconColor, String text) {
    return Container(
      width: 160,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7)
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 40.0),
            const SizedBox(height: 8),
            Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(text,
              style: const TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}
