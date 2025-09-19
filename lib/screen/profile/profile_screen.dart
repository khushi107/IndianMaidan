// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'widgets/activity_overview_card.dart';
import 'widgets/profile_hero_card.dart';
import 'widgets/quick_actions_grid.dart';
import 'widgets/account_actions_section.dart';
import 'widgets/social_connect_section.dart';
import 'widgets/support_modal.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _showSupportModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const SupportModal(),
    );
  }
  
  // TODO: Create and implement the Favorites Modal
  void _showFavoritesModal(BuildContext context) {
     // showModalBottomSheet for favorites...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.lightGrey,
            child: Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile", style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold, fontSize: 20)),
            Text("Manage your account", style: TextStyle(color: AppColors.midGrey, fontSize: 12)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFE65100), Color(0xFFFF6F00)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeroCard(),
            const SizedBox(height: 8),
            const ActivityOverviewCard(),
            QuickActionsGrid(
              onMyBookingsTap: () {
                  // TODO: Navigate to Bookings Screen
              },
              onFindVenuesTap: () {
                  // TODO: Navigate to Explore Screen
              },
              onFavoritesTap: () => _showFavoritesModal(context),
              onSupportTap: () => _showSupportModal(context),
            ),
            const SizedBox(height: 16),
            const AccountActionsSection(),
            const SocialConnectSection(),
          ],
        ),
      ),
    );
  }
}