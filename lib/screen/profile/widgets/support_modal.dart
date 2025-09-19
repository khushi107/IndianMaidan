// lib/screens/profile/widgets/support_modal.dart
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class SupportModal extends StatelessWidget {
  const SupportModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Contact Support", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
          const SizedBox(height: 24),
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryOrange,
            child: Text("IM", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          const Text("INDIAN MAIDAN", style: TextStyle(color: AppColors.primaryOrange, fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("Your Sports Booking Partner", style: TextStyle(color: AppColors.midGrey)),
          const Divider(height: 40),
          const Text("Get in Touch", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
          const SizedBox(height: 16),
          _buildContactTile(Icons.phone, "Phone", "+91 98765 43210", AppColors.green),
          _buildContactTile(Icons.email, "Email", "support@indianmaidan.com", AppColors.blue),
          _buildContactTile(Icons.message, "WhatsApp", "+91 98765 43210", AppColors.green),
          _buildContactTile(Icons.location_city, "Office", "Bhilwara, Rajasthan, India", AppColors.primaryOrange),
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.midGrey)),
      onTap: () {
        // TODO: Implement url_launcher to call/email/etc.
      },
    );
  }
}