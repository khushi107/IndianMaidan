// lib/screens/main_navigation_screen.dart

import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/screen/home_screen.dart';
import 'home/home_screen.dart';
import 'explore/explore_screen.dart';
import 'bookings/bookings_screen.dart';
import 'profile/profile_screen.dart';
import '../utils/colors.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // List of the main screens
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ExploreScreen(),
    const BookingsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps the state of the screens when switching tabs
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryOrange,
        unselectedItemColor: AppColors.midGrey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}