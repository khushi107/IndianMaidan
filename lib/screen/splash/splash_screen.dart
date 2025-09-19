import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../auth/auth_screen.dart';
import '../main_navigation_screen.dart';
import '../../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    // Start the animation, and when it's done, check the login status.
    _controller.forward().whenComplete(_checkAuthAndNavigate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkAuthAndNavigate() async {
    // We use listen: false here because we're not in the build method.
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final bool isLoggedIn = await authProvider.tryAutoLogin();

    // Ensure the widget is still mounted before navigating to avoid errors.
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // If logged in, go to the main app screen. If not, go to the authentication screen.
          builder: (context) => isLoggedIn ? const MainNavigationScreen() : const AuthScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: FadeTransition(
          opacity: _logoAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // NOTE: Make sure you have configured your assets in pubspec.yaml
              Image.asset('assets/images/logo.png', height: 150),
              const SizedBox(height: 20),
              const Text(
                'Your Turf, Your Game',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002868), // Navy Blue
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}