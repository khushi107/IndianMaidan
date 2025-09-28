// lib/screen/auth/auth_screen.dart
import 'widgets/signin_form.dart';
import 'widgets/signup_form.dart';
import '../main_navigation_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background, // Use a valid background color
        appBar: AppBar(
  toolbarHeight: 60,
  elevation: 0,
  backgroundColor: Colors.transparent,
  automaticallyImplyLeading: false,
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B35).withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Skip',
          style: TextStyle(
            color: Color(0xFFFF6B35),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  ],
),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Replace with your actual logo
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.lightGrey,
                    child: Icon(Icons.sports_soccer, size: 40, color: AppColors.primaryNavy),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Indian Maidan',
                    style: TextStyle(
                      color: AppColors.primaryNavy, // CORRECTED
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Play Bold | Achieve Goal | Get Gold',
                    style: TextStyle(
                      color: AppColors.darkGrey, // CORRECTED
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.green, width: 2),
                      ),
                      labelColor: AppColors.green,
                      unselectedLabelColor: AppColors.darkGrey,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      tabs: const [
                        Tab(text: 'Sign In'),
                        Tab(text: 'Sign Up'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    // Giving enough height for the form content
                    height: 500,
                    child: TabBarView(
                      children: [
                        SignInForm(),
                        SignUpForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}