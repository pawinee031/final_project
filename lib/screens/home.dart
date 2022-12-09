import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/actions/auth.dart';
import 'package:project/screens/admin/admin_main.dart';
import 'package:project/screens/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book/booking.dart';
import 'history/history.dart';
import 'home/main_section.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> pageTitle = [
    "Home",
    "Booking",
    "History",
    "Profile",
  ];

  List<Widget> screens = [
    MainSection(),
    BookingPage(),
    HistoryPage(),
    ProfilePage(),
  ];
  int currentIndex = 0;
  List<GButton> navItems = [
    GButton(icon: Ionicons.home_outline, text: "Home"),
    GButton(icon: Ionicons.book_outline, text: "Booking"),
    GButton(icon: Ionicons.receipt_outline, text: "History"),
    GButton(icon: Ionicons.person_circle_outline, text: "Profile"),
  ];

  _onChangeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  _isUserLogin() async {
    print('check user login ');

    SharedPreferences sp = await SharedPreferences.getInstance();
    int? isAdmin = sp.getInt('isAdmin');

    if (isAdmin == 1)
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminMain(),
          ),
          (route) => false);
    if (isAdmin == 0) print('test');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      // _isUserLogin();

      print('test');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(pageTitle[currentIndex]),
        elevation: 0,
        toolbarHeight: 80,
      ),
      primary: true,
      bottomNavigationBar: Container(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 5,
                    color:
                        Color.fromARGB(255, 241, 236, 236).withOpacity(0.8))),
          ),
          child: SafeArea(
            child: GNav(
              tabs: navItems,
              gap: 20,
              padding: const EdgeInsets.all(15),
              tabActiveBorder: Border.all(),
              haptic: true,
              tabBorderRadius: 100.00,
              onTabChange: (index) => _onChangeIndex(index),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: screens[currentIndex],
      ),
    );
  }
}
