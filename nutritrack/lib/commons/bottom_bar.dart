import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutritrack/commons/global_variables.dart';
import 'package:nutritrack/screens/calendar.dart';
import 'package:nutritrack/screens/home.dart';
import 'package:nutritrack/screens/profile.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  List pages = [
    const HomeScreen(),
    const CalendarScreen(),
    const ProfileScreen(),
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_index],
      bottomNavigationBar: FloatingNavbar(
        selectedItemColor: GlobalVariables.mainColor,
        backgroundColor: GlobalVariables.mainColor,
        margin: EdgeInsets.zero,
        onTap: (int val) => setState(() => _index = val),
        currentIndex: _index,
        items: [
          FloatingNavbarItem(
            icon: Icons.home,
          ),
          FloatingNavbarItem(
            icon: Icons.calendar_month,
          ),
          FloatingNavbarItem(
            icon: Icons.person,
          )
        ],
      ),
    );
  }
}
