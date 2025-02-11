import 'dart:async';
import 'dart:convert';
import 'package:app/model/menu_odels.dart';
import 'package:app/services/rest_api.dart';
import 'package:app/utils/utility.dart';
import 'package:flutter/material.dart';

class Save1 extends StatefulWidget {
  const Save1({super.key});

  @override
  State<Save1> createState() => _Save1State();
}

class _Save1State extends State<Save1> {
  String food = 'เมนูอาหาร';
  String rice = 'ผลไม้';
  String water = 'เมนูน้ำ';

  double eat = 0.0;
  late Timer _dailyResetTimer;

  List<String> foodList = ['เมนูอาหาร', 'ข้าวผัด'];
  List<String> riceList = [
    'ผลไม้',
  ];
  List<String> waterList = ['เมนูน้ำ', 'น้ำส้ม'];

  void submitFood() async {
    var data = {
      'food': food,
      'fruit': rice,
      'drink': water,
    };
    print(data);
    if (food != 'เมนูอาหาร' || rice != 'ผลไม้' || water != 'เมนูน้ำ') {
      var response = await CallAPI().Save_1INSERT(data);

      // Log ข้อมูลที่ได้จาก API
      Utility().logger.i(response);

      var body = jsonDecode(response);

      if (body['successful'] == 'success') {
        String? lastDate = Utility.getSharedPreference('last_reset_date');
        double kkal = 0.0;
        kkal = await Utility.getSharedPreference('Kcal $lastDate') ?? 0.0;
        await Utility.setSharedPreference(
            'Kcal $lastDate', (body['data']['kcal'] / 1000) + kkal);

        setState(() {
          eat = (body['data']['kcal'] / 1000) + kkal;
        });
      }
    }
  }





  getUserProfile() async {
    var response = await CallAPI().getMenuAPI();
    var body = jsonDecode(response);
    MenuModel menuModel = MenuModel.fromJson(body);
    // Utility().logger.d(response);
    String? lastDate = Utility.getSharedPreference('last_reset_date');
    double kkal = 0.0;
    kkal = await Utility.getSharedPreference('Kcal $lastDate') ?? 0.0;
    setState(() {
      eat = kkal;
      if (menuModel.data.isNotEmpty) {
        // ลูปเช็คแต่ละรายการใน menuModel.data
        for (var category in menuModel.data) {
          if (category.name == "อาหาร") {
            foodList = category.menudata.map((item) => item.name).toList();
          } else if (category.name == "ผลไม้") {
            riceList = category.menudata.map((item) => item.name).toList();
          } else if (category.name == "เมนูน้ำ") {
            waterList = category.menudata.map((item) => item.name).toList();
          }
        }
      }
    });

    // setState(() {
    //   if (menuModel.data.isNotEmpty) {
    //     if (menuModel.data[0].name == "อาหาร") {
    //       foodList = menuModel.data[0].menudata.map((item) => item.name).toList();
    //     }
    //     if (menuModel.data[1].name == "ผลไม้") {
    //       riceList = menuModel.data[1].menudata.map((item) => item.name).toList();
    //     }
    //      if (menuModel.data[2].name == "เมนูน้ำ") {
    //       waterList = menuModel.data[2].menudata.map((item) => item.name).toList();
    //     }
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'บันทึกอาหาร',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // ทำให้ข้อความอยู่กลาง
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdownCard('เมนูอาหาร', foodList, food, (value) {
                setState(() {
                  food = value!;
                });
              }),
              buildDropdownCard('ผลไม้', riceList, rice, (value) {
                setState(() {
                  rice = value!;
                });
              }),
              buildDropdownCard('เมนูน้ำ', waterList, water, (value) {
                setState(() {
                  water = value!;
                });
              }),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: submitFood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 105, 102, 92),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'ยืนยัน',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${eat.toStringAsFixed(2)} กิโลแคลอรี',
                    style: TextStyle(
                      color: Color.fromARGB(255, 90, 93, 79),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownCard(
    String label,
    List<String> items,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: Colors.grey[900],
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
