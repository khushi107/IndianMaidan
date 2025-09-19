// lib/screens/profile/widgets/social_connect_section.dart

import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class SocialConnectSection extends StatelessWidget {
  const SocialConnectSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          const Text("Connect with us", style: TextStyle(color: AppColors.midGrey, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.email, const Color(0xFFEA4335)),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.camera_alt, const Color(0xFFE4405F)), // Placeholder for Instagram
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.facebook, const Color(0xFF1877F2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {
          // TODO: Implement URL launcher logic for social links
        },
      ),
    );
  }
}