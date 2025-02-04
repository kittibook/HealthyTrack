import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Book2 extends StatefulWidget {
  const Book2({super.key});
  @override
  State<Book2> createState() => _Book2State();
}

class _Book2State extends State<Book2> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 10, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                        'จำนวนก้าวเดิน',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 300.0,
                        child: BarChart(
                          BarChartData(
                            barGroups: showingBarGroups,
                            borderData: FlBorderData(
                                border: const Border(
                                    bottom: BorderSide(), left: BorderSide())),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles:
                                  AxisTitles(sideTitles: _bottomTitles),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
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
                        'ผลการติดตามสุขภาพ',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 300.0,
                        child: BarChart(
                          BarChartData(
                            barGroups: showingBarGroups,
                            borderData: FlBorderData(
                                border: const Border(
                                    bottom: BorderSide(), left: BorderSide())),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles:
                                  AxisTitles(sideTitles: _bottomTitles),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
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

  // แก้ไขให้ return เป็น List<BarChartGroupData> แทน List<List<BarChartGroupData>>
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
          switch (value.toInt()) {
            case 0:
              text = 'Jan';
              break;
            case 2:
              text = 'Mar';
              break;
            case 4:
              text = 'May';
              break;
            case 6:
              text = 'Jul';
              break;
            case 8:
              text = 'Sep';
              break;
            case 10:
              text = 'Nov';
              break;
          }

          return Text(text, style: TextStyle(color: Colors.white));
        },
      );
}
