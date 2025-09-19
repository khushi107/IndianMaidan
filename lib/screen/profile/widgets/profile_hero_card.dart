// lib/screens/profile/widgets/profile_hero_card.dart
import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/utils/gradiants.dart';
import '../../../utils/colors.dart';

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with dynamic user data from a ProfileProvider
    const String name = "Khushi Modi";
    const String location = "Bhilwara, Rajasthan";
    const String memberSince = "Member since 2023";
    const String email = "khushi@example.com";
    const String phone = "+91xbxbxbxbxbxbx";

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.orangeGradient, // [cite: 105]
        borderRadius: BorderRadius.circular(20), // [cite: 106]
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 3), // [cite: 109]
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      // TODO: Replace with user's profile image
                      backgroundImage: NetworkImage("https://images.unsplash.com/photo-1570295999919-56ceb5ecca61"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.darkGrey,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(name, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), // [cite: 112]
                  const SizedBox(height: 4),
                  _buildInfoBadge(Icons.location_on, location),
                  const SizedBox(height: 4),
                  _buildInfoBadge(Icons.military_tech, memberSince),
                ],
              )
            ],
          ),
          const Divider(color: Colors.white30, height: 30),
          Row(
            children: [
              _buildContactInfo(Icons.email, "Email", email),
              _buildContactInfo(Icons.phone, "Phone", phone),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15), // [cite: 113]
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String value) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white, // [cite: 117]
            child: Icon(icon, color: AppColors.primaryOrange, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)), // [cite: 118]
            ],
          )
        ],
      ),
    );
  }
}