import 'package:app/screen/botomnavbar/home_screen_bottomnav.dart';
import 'package:app/screen/botomnavbar/menu_screen_bottomnav.dart';
import 'package:app/screen/botomnavbar/profile_screen_bottomnav.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class NAV extends StatefulWidget {
  const NAV({super.key});

  @override
  State<NAV> createState() => _NAVState();
}

class _NAVState extends State<NAV> {
  String _title = 'หน้าหลัก';

  // สร้างตัวแปรเก็บ index ของแต่ละหน้า
  int _currentIndex = 0;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    Home(),
    MenuScreenBottomnav(),
    ProfileScreenBottomnav()
  ];

  void onTabTapped(int index) {
    setState(
      () {
        _currentIndex = index;
        switch (index) {
          case 0:
            _title = 'หน้าหลัก';
            break;
          case 1:
            _title = 'เมนู';
            break;
          case 2:
            _title = 'โปรไฟล์';
            break;
          default:
            _title = 'หน้าหลัก';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text(_title, style: const TextStyle( color: Colors.white),)),
      ),
      backgroundColor: Colors.black,
      body: _children[_currentIndex],
      bottomNavigationBar: CrystalNavigationBar(
          currentIndex: _currentIndex,
          height: 10,
          // indicatorColor: Colors.blue,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.3),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 4,
          //     spreadRadius: 4,
          //     offset: Offset(0, 10),
          //   ),
          // ],
          onTap: (value) {
            onTabTapped(value);
          },
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: const Color.fromARGB(255, 100, 23, 23),
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.category,
              unselectedIcon: IconlyLight.category,
              selectedColor: const Color.fromARGB(255, 100, 23, 23),
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.profile,
              unselectedIcon: IconlyLight.profile,
              selectedColor: const Color.fromARGB(255, 100, 23, 23),
            ),
          ]),
    );
  }
}
