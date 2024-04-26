import 'package:bookstore/View/HomeScreen/home.dart';
import 'package:bookstore/View/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'View/Authors/Authors.dart';
import 'View/Books/Books.dart';
import 'View/Pages/about.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _homeScreenState();
}

class _homeScreenState extends State<MainMenu> {

  // ----------------------------
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
     HomeScreen(),
    const Books(),
    const Authors(),
    const about(),
    LoginPage(),
  ];

  // bottomNavigationBar  كود تغير ال
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BookShop'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed("/setting");
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'القائمة',
              tooltip: 'Home',
              activeIcon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_add),
              label: 'الكتب',
              tooltip: 'books',
              activeIcon: Icon(Icons.library_add_check_outlined),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'المؤلفين',
              tooltip: 'authors',
              activeIcon: Icon(Icons.supervised_user_circle_sharp),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'حول',
              tooltip: 'about',
              activeIcon: Icon(Icons.info_outline_rounded),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.login_sharp),
              label: 'لحساب',
              tooltip: 'login',
              activeIcon: Icon(Icons.login),
            ),
          ],
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}