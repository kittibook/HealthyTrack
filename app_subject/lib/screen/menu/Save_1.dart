import 'package:flutter/material.dart';

class Save1 extends StatefulWidget {
  const Save1({super.key});

  @override
  State<Save1> createState() => _Save1State();
}

class _Save1State extends State<Save1> {
  String food = 'เมนูอาหาร';
  String rice = 'ข้าว';
  String water = 'เมนูน้ำ';

  final List<String> foodList = ['เมนูอาหาร', 'ข้าวผัด'];
  final List<String> riceList = ['ข้าว', 'ข้าวสวย', 'ผัดกระเพรา'];
  final List<String> waterList = ['เมนูน้ำ', 'น้ำส้ม'];

  void submitFood() {
    print('เมนูอาหาร: $food');
    print('ข้าว: $rice');
    print('เมนูน้ำ: $water');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('บันทึกอาหาร', style: TextStyle(color: Colors.white),),
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
              buildDropdownCard('ข้าว', riceList, rice, (value) {
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
                  child: const Text(
                    '0 กิโลแคลอรี',
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
