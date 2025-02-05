import 'dart:convert';
import 'package:app/services/rest_api.dart';
import 'package:app/utils/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Book2 extends StatefulWidget {
  const Book2({super.key});
  @override
  State<Book2> createState() => _Book2State();
}

class _Book2State extends State<Book2> {
  late List<BarChartGroupData> showingBarGroups = [];
  late List<BarChartGroupData> showingBarGroups2 = [];
  late List<BarChartGroupData> showingBarGroups3 = [];
  late List<BarChartGroupData> showingBarGroups4 = [];
  late List<BarChartGroupData> showingBarGroups5 = [];
  late List<BarChartGroupData> showingBarGroups6 = [];
  bool isLoading = true; // ตัวแปรเช็คสถานะการโหลดข้อมูล

  void getchartkcal() async {
    var response = await CallAPI().getchartToRun1API();
    var body = jsonDecode(response);

    if (body['successfull'] == "success") {
      setState(() {
        showingBarGroups = generateWeeklyData(body['week']);
        isLoading = false; // เปลี่ยนสถานะเมื่อข้อมูลโหลดเสร็จ
      });
    }
  }

  void getchartwalk() async {
    var response = await CallAPI().getchartwalkAPI();
    var body = jsonDecode(response);
    if (body['successfull'] == "success") {
      setState(() {
        showingBarGroups2 = generateWeeklyData(body['week']);
        isLoading = false; // เปลี่ยนสถานะเมื่อข้อมูลโหลดเสร็จ
      });
    }
  }

  void getchartwalkkcal() async {
    var response = await CallAPI().getchartwalkkcalAPI();
    var body = jsonDecode(response);
    if (body['successfull'] == "success") {
      setState(() {
        showingBarGroups6 = generateWeeklyData(body['week']);
        isLoading = false; // เปลี่ยนสถานะเมื่อข้อมูลโหลดเสร็จ
      });
    }
  }

  void getchartall() async {
    var response = await CallAPI().getchartallAPI();
    var body = jsonDecode(response);
    if (body['successfull'] == "success") {
      setState(() {
        showingBarGroups3 = generateWeeklyData1(body['bmi']);
        showingBarGroups4 = generateWeeklyData1(body['pressure']);
        showingBarGroups5 = generateWeeklyData1(body['sugarlevel']);
        isLoading = false; // เปลี่ยนสถานะเมื่อข้อมูลโหลดเสร็จ
      });
    }
  }

  List<BarChartGroupData> generateWeeklyData(week) {
    return List.generate(week.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: week[index].toDouble(),
            color: Colors.blue,
            width: 20,
          ),
        ],
      );
    });
  }

  List<BarChartGroupData> generateWeeklyData1(week) {
    return List.generate(week.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: week[index].toDouble(),
            color: const Color.fromARGB(255, 10, 109, 61),
            width: 20,
          ),
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getchartkcal(); // ดึงข้อมูลเมื่อหน้าโหลด
    getchartwalk();
    getchartall();
    getchartwalkkcal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'รายงานและการวิเราะห์',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // แสดงการโหลดข้อมูล
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // เลื่อนได้แนวนอน
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 50, 50, 50),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'พลังงานที่ได้รับ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 20.0),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 300.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: showingBarGroups,
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(),
                                                  left: BorderSide())),
                                          gridData: const FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _bottomTitles),
                                            leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 50, 50, 50),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'จำนวนก้าวเดิน',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 300.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: showingBarGroups2,
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(),
                                                  left: BorderSide())),
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _bottomTitles),
                                            leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 50, 50, 50),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'พลังงานที่เคลื่อนไหว',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 300.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: showingBarGroups6,
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(),
                                                  left: BorderSide())),
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _bottomTitles),
                                            leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // แสดงกราฟอีกตัวตามต้องการ
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // เลื่อนได้แนวนอน
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 50, 50, 50),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'ค่า BMI',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 300.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: showingBarGroups3,
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(),
                                                  left: BorderSide())),
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _bottomTitlesM),
                                            leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 50, 50, 50),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'ค่า ความดัน',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 300.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: showingBarGroups4,
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(),
                                                  left: BorderSide())),
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _bottomTitlesM),
                                            leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color.fromARGB(255, 50, 50, 50),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'ค่า ความน้ำตาลในเลือด',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 20.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 300.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: showingBarGroups5,
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(),
                                                  left: BorderSide())),
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                                sideTitles: _bottomTitlesM),
                                            leftTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // แสดงกราฟอีกตัวตามต้องการ
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.blue,
          width: 20,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.red,
          width: 20,
        ),
      ],
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          int dayIndex = value.toInt(); // ใช้ค่า x ที่เป็นหมายเลขวันในสัปดาห์

          // กำหนดชื่อวันตามหมายเลข
          switch (dayIndex) {
            case 0:
              text = 'จันทร์';
              break;
            case 1:
              text = 'อังคาร';
              break;
            case 2:
              text = 'พุธ';
              break;
            case 3:
              text = 'พฤหัส';
              break;
            case 4:
              text = 'ศุกร์';
              break;
            case 5:
              text = 'เสาร์';
              break;
            case 6:
              text = 'อาทิตย์';
              break;
            default:
              text = '';
          }

          return Text(text, style: TextStyle(color: Colors.white));
        },
      );

  SideTitles get _bottomTitlesM => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          int monthIndex = value.toInt(); // ใช้ค่า x ที่เป็นหมายเลขเดือน

          // กำหนดชื่อเดือนตามหมายเลข (ตัวย่อ)
          switch (monthIndex) {
            case 0:
              text = 'ม.ค.';
              break;
            case 1:
              text = 'ก.พ.';
              break;
            case 2:
              text = 'มี.ค.';
              break;
            case 3:
              text = 'เม.ย.';
              break;
            case 4:
              text = 'พ.ค.';
              break;
            case 5:
              text = 'มิ.ย.';
              break;
            case 6:
              text = 'ก.ค.';
              break;
            case 7:
              text = 'ส.ค.';
              break;
            case 8:
              text = 'ก.ย.';
              break;
            case 9:
              text = 'ต.ค.';
              break;
            case 10:
              text = 'พ.ย.';
              break;
            case 11:
              text = 'ธ.ค.';
              break;
            default:
              text = '';
          }

          return Text(text, style: TextStyle(color: Colors.white));
        },
      );
}
