// lib/screen/welcome/welcome_screen.dart
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../auth/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF), // White
              Color(0xFFF8FAFC), // Light Blue
              Color(0xFFF1F5F9), // Lighter Blue
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  
                  // Floating Pattern Background (Subtle circles)
                  Stack(
                    children: [
                      // Background circles with Indian flag colors
                      Positioned(
                        top: 20,
                        right: 30,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFF6B35).withOpacity(0.04),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 20,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF059669).withOpacity(0.04),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180,
                        right: 60,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1E40AF).withOpacity(0.04),
                          ),
                        ),
                      ),
                      
                      // Main Content
                      Column(
                        children: [
                          // Logo Section
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFFF6B35).withOpacity(0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1E40AF),
                                ),
                                child: const Icon(
                                  Icons.sports_soccer,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Header Text Section
                          const Text(
                            'Find, Book & Play',
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          const Text(
                            'Welcome to Indian Maidan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1E40AF),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Main Action Button
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const AuthScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6B35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 6,
                                shadowColor: const Color(0xFFFF6B35).withOpacity(0.3),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Start Booking',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Description Text
                          Text(
                            'Book your perfect sports facilities in just few clicks - Turn Your Passion into Play',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF6B7280).withOpacity(0.8),
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Feature Boxes Section
                          Row(
                            children: [
                              Expanded(
                                child: _buildFeatureBox(
                                  icon: Icons.card_membership_outlined,
                                  title: 'No Platform\nCharges',
                                  iconColor: const Color(0xFF059669),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildFeatureBox(
                                  icon: Icons.list_alt_outlined,
                                  title: 'Quick\nBooking',
                                  iconColor: const Color(0xFFFF6B35),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildFeatureBox(
                                  icon: Icons.shield_outlined,
                                  title: 'Secure\nBooking',
                                  iconColor: const Color(0xFF1E40AF),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Partner Link Button
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF059669),
                                width: 1,
                              ),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                // TODO: Navigate to partner portal
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Partner portal coming soon!'),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.business,
                                color: Color(0xFF059669),
                                size: 20,
                              ),
                              label: const Text(
                                'Turf Owner? Join Us',
                                style: TextStyle(
                                  color: Color(0xFF059669),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBox({
    required IconData icon,
    required String title,
    required Color iconColor,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1E40AF),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}