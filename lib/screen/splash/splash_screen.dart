import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/utils/colors.dart';
import 'package:indian_maidan_flutter/widgets/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.bgTop, AppColors.bgMid, AppColors.bgBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo in white circle with saffron border
                Container(
                  width: 140, height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.saffron.withOpacity(.2), width: 2),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0,6))],
                  ),
                  child: Center(
                    child: Image.asset('assets/images/logo.png', width: 120, height: 120),
                  ),
                ),
                const SizedBox(height: 24),
                // Subtitle + Title
                Text('Find, Book & Play',
                    style: TextStyle(color: AppColors.saffron, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text('Welcome to Indian Maidan',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.navy)),
                const SizedBox(height: 16),
                Text(
                  'Book your perfect sports facilities in just few clicks - Turn Your Passion into Play',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black.withOpacity(.7)),
                ),
                const Spacer(),
                CustomButton(
                  text: 'Start Booking',
                  onPressed: () => Navigator.pushNamed(context, '/auth/player'),
                ),
                const SizedBox(height: 12),
                // “Turf Owner? Join Us” (green)
                TextButton(
                  onPressed: () {
                    // later: navigate to owner onboarding flow
                    Navigator.pushNamed(context, '/auth/player'); // placeholder
                  },
                  child: const Text('Turf Owner? Join Us', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
