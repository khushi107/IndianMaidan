// lib/screens/profile/widgets/activity_overview_card.dart
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class ActivityOverviewCard extends StatelessWidget {
  const ActivityOverviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with dynamic data
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // [cite: 127]
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withOpacity(0.8),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Activity Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              children: [
                _buildStatItem(context, icon: Icons.calendar_today, value: "24", label: "Total Bookings", color: AppColors.primaryOrange), // [cite: 142]
                const VerticalDivider(color: AppColors.border, thickness: 1), // [cite: 131]
                _buildStatItem(context, icon: Icons.timelapse, value: "2", label: "Upcoming", color: AppColors.yellow), // [cite: 143]
              ],
            ),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSecondaryStat("48 hrs", "Played", AppColors.green), // [cite: 144]
              _buildSecondaryStat("1", "Cancelled", AppColors.red), // [cite: 146]
              _buildSecondaryStat("8", "Favorites", AppColors.pink), // [cite: 147]
            ],
          ),
          const SizedBox(height: 16),
          _buildNextBookingCard(),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, {required IconData icon, required String value, required String label, required Color color}) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
              Text(label, style: const TextStyle(color: AppColors.midGrey)),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSecondaryStat(String value, String label, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.circle, color: color, size: 10),
            const SizedBox(width: 6),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkGrey, fontSize: 14)), // [cite: 134]
          ],
        ),
        Text(label, style: const TextStyle(color: AppColors.midGrey, fontSize: 12)),
      ],
    );
  }

  Widget _buildNextBookingCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]), // [cite: 137]
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.event_available, color: AppColors.green)), // [cite: 139]
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Next Booking", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Today 6:00 PM - Elite Football Arena", style: TextStyle(color: Colors.white70, fontSize: 12)), // [cite: 151]
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}