import 'package:app_subject/app_router.dart';
import 'package:flutter/material.dart';

class MenuScreenBottomnav extends StatefulWidget {
  const MenuScreenBottomnav({super.key});

  @override
  State<MenuScreenBottomnav> createState() => _MenuScreenBottomnavState();
}

class _MenuScreenBottomnavState extends State<MenuScreenBottomnav> {
  final menuItems = [
    {
      'name': 'การบันทึกการรับประทานอาหาร',
      'img': 'assets/images/1.png',
      'path': AppRouter.menusave
    },
    {
      'name': 'ติดตามกิจกรรมทางกาย',
      'img': 'assets/images/4.png',
      'path': AppRouter.menusave2
    },
    {
      'name': 'บันทึกการทำสมาธิ',
      'img': 'assets/images/3.png',
      'path': AppRouter.menuarm
    },
    {
      'name': 'ติดตามการบิณฑบาต',
      'img': 'assets/images/2.png',
      'path': AppRouter.menuarm2
    },
    {
      'name': 'ติดตามสุขภาพด้วยตนเอง',
      'img': 'assets/images/5.png',
      'path': AppRouter.menubook
    },
    {
      'name': 'รายงานและการวิเคราะห์',
      'img': 'assets/images/6.png',
      'path': AppRouter.menubook2
    },
    // "การบันทึกการรับประทานอาหาร",
    // "ติดตามการนับแคลอรี",
    // "บันทึกการทำสมาธิ",
    // "ติดตามกิจกรรมทางกาย",
    // "ติดตามสุขภาพด้วยตนเอง",
    // "รายงานและการวิเคราะห์",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return LayoutBuilder(
              builder: (context, constraint) => GestureDetector(
                onTap: () {
                  // Define what happens when the item is tapped
                  Navigator.pushNamed(context, menuItems[index]['path']!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200 * 0.60,
                        child: Image.asset(menuItems[index]['img']!),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          menuItems[index]['name']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
