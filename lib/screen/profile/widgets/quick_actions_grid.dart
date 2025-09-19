// lib/screens/profile/widgets/quick_actions_grid.dart

import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/gradiants.dart';

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onMyBookingsTap;
  final VoidCallback onFindVenuesTap;
  final VoidCallback onFavoritesTap;
  final VoidCallback onSupportTap;

  const QuickActionsGrid({
    Key? key,
    required this.onMyBookingsTap,
    required this.onFindVenuesTap,
    required this.onFavoritesTap,
    required this.onSupportTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildActionCard(
                gradient: AppGradients.orangeGradient,
                icon: Icons.calendar_today,
                title: "My Bookings",
                subtitle: "View & manage",
                onTap: onMyBookingsTap,
              ),
              _buildActionCard(
                gradient: AppGradients.blueGradient,
                icon: Icons.search,
                title: "Find Venues",
                subtitle: "Explore nearby",
                onTap: onFindVenuesTap,
              ),
              _buildActionCard(
                gradient: AppGradients.redGradient,
                icon: Icons.favorite,
                title: "Favorites",
                subtitle: "Saved venues",
                onTap: onFavoritesTap,
              ),
              _buildActionCard(
                gradient: AppGradients.greenGradient,
                icon: Icons.support_agent,
                title: "Support",
                subtitle: "Get help",
                onTap: onSupportTap,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required Gradient gradient,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (gradient as LinearGradient).colors.first.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}