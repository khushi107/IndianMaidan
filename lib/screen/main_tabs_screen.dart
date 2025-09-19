// lib/screens/main_tabs_screen.dart

import 'package:flutter/material.dart';
// FIX 1: Use the correct package import path
import 'package:indian_maidan_flutter/screen/home_screen.dart'; 
import 'package:indian_maidan_flutter/utils/colors.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text('Explore Screen')),
    const Center(child: Text('Bookings Screen')),
    const Center(child: Text('Profile Screen')),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // FIX 2: Use the color from your AppColors class
        selectedItemColor: AppColors.saffron, 
        unselectedItemColor: Colors.grey[500],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 5.0,
        items: const [
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
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}