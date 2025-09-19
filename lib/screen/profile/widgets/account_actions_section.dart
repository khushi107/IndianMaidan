// lib/screens/profile/widgets/account_actions_section.dart

import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class AccountActionsSection extends StatelessWidget {
  const AccountActionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Account Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.red.withOpacity(0.1),
                child: const Icon(Icons.logout, color: AppColors.red),
              ),
              title: const Text("Sign Out", style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold)),
              subtitle: const Text("Sign out of your account", style: TextStyle(color: AppColors.midGrey)),
              onTap: () {
                // TODO: Implement sign out logic
              },
            ),
          ),
        ],
      ),
    );
  }
}