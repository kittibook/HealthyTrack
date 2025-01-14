import 'dart:async';

import 'package:flutter/material.dart';

class Arm1 extends StatefulWidget {
  const Arm1({super.key});

  @override
  State<Arm1> createState() => _Arm1State();
}

class _Arm1State extends State<Arm1> {
  Timer? _timer;
  Duration _duration = Duration.zero;
  bool _isRunning = false;
  Duration _lastDuration = Duration.zero; // บันทึกเวลาล่าสุด

  bool isLeftSelected = false;
  bool isRightSelected = false;

  void _startOrStopTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _duration += const Duration(milliseconds: 100);
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    // บันทึกเวลาล่าสุดก่อนทำการรีเซ็ต
    setState(() {
      _lastDuration = _duration;
      _timer?.cancel();
      _isRunning = false;
      _duration = Duration.zero;
    });

    // แสดงข้อความบันทึกเวลา
    _showTimeSavedDialog();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hundredths = ((duration.inMilliseconds % 1000) / 10)
        .toStringAsFixed(0)
        .padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes % 60)}:${twoDigits(duration.inSeconds % 60)}.$hundredths";
  }

  void _showTimeSavedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("เวลาถูกบันทึกแล้ว"),
          content: Text("เวลาของคุณคือ: ${_formatDuration(_lastDuration)}"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ตกลง"),
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
        title: const Text('บันทึกการทำสมาธิ',
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
            Text(
              _formatDuration(_duration),
              style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                onPressed: _startOrStopTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRunning ? Colors.red : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(
                  _isRunning ? 'หยุด' : 'เริ่ม',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'บันทึกและเริ่มใหม่',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ปุ่มเดินจงกรม
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLeftSelected = !isLeftSelected;
                      if (isLeftSelected) {
                        isRightSelected = false;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                        color:
                            isLeftSelected ? Colors.yellow : Colors.transparent,
                        width: 2),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(24), // เพิ่มมุมโค้งที่มากขึ้น
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.directions_walk, color: Colors.yellow),
                      SizedBox(width: 8),
                      Text('เดินจงกรม', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // ปุ่มนั่งสมาธิ
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isRightSelected = !isRightSelected;
                      if (isRightSelected) {
                        isLeftSelected = false;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                        color:
                            isRightSelected ? Colors.green : Colors.transparent,
                        width: 2),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(24), // เพิ่มมุมโค้งที่มากขึ้น
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.self_improvement, color: Colors.green),
                      SizedBox(width: 8),
                      Text('นั่งสมาธิ', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
