import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Save2 extends StatefulWidget {
  const Save2({super.key});

  @override
  State<Save2> createState() => _Save2State();
}

class _Save2State extends State<Save2> {
  int _seconds = 0;
  bool _isTimerRunning = false;
  late Timer _timer;
  late Activity _currentActivity;

  void _startTimer(Activity activity) {
    setState(() {
      _currentActivity = activity;
      _isTimerRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds < 30 * 60) {
        setState(() {
          _seconds++;
        });
      } else {
        _timer.cancel();
        setState(() {
          _isTimerRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildActivityGrid(),
            if (_isTimerRunning) ...[
              const SizedBox(height: 16),
              _buildCurrentActivity(),
              const SizedBox(height: 16),
              _buildLargeTimer(),
            ]
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      title: const Text(
        'ติดตามกิจกรรมทางกาย',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildActivityGrid() {
    final activities = [
      Activity(
          title: 'กวาดลานวัด', duration: '30 นาที', calories: '1000 Kcal '),
      Activity(title: 'เดินจงกรม', duration: '30 นาที', calories: '500 Kcal'),
      Activity(title: 'วิ่งจงกรม', duration: '30 นาที', calories: '500 Kcal'),
    ];

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.8,
        ),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return _buildActivityCard(activity);
        },
      ),
    );
  }

  Text _buildCurrentActivity() {
    return Text(
      'กำลังทำกิจกรรม: ${_currentActivity.title}',
      style: const TextStyle(color: Colors.white, fontSize: 24),
    );
  }

  Widget _buildLargeTimer() {
    int minutes = (_seconds / 60).floor();
    int seconds = _seconds % 60;
    String formattedTime = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 25.0,
            animation: true,
            percent: _seconds / (30 * 60), // Max timer value is 30 minutes
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: const Color.fromARGB(255, 183, 48, 39),
            backgroundColor: const Color.fromARGB(255, 100, 37, 32),
          ),
          const SizedBox(height: 8),
          Text(
            formattedTime, // Display formatted time (mm:ss)
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _stopTimer,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'หยุด',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Activity activity) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade700, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              activity.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              activity.calories,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              activity.duration, // แสดง duration ที่นี่
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (!_isTimerRunning) {
                  _startTimer(activity);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'เริ่ม',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Activity {
  final String title;
  final String duration;
  final String calories;

  const Activity({
    required this.title,
    required this.duration,
    required this.calories,
  });
}