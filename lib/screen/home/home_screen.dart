import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import '../../utils/colors.dart';
import '../../utils/gradiants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildSearchBar(),
                _buildExploreCard(),
                _buildUpcomingBookingCard(),
                _buildSectionHeader("Sports Categories"),
                _buildSportsCategories(),
                _buildSectionHeader("Featured Turfs"),
                _buildFeaturedTurfs(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // TODO: Fetch user name dynamically
    const userName = "Khushi";
    
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.headerGradient,
        ),
        child: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Evening', // TODO: Make this dynamic
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkGrey),
                    ),
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryNavy, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.notifications, color: AppColors.primaryNavy),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryOrange, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 16,
                        // TODO: Add user profile image
                        child: Text("D", style: TextStyle(color: Colors.white)),
                        backgroundColor: AppColors.primaryNavy,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          centerTitle: false,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search turfs, sports, locations...',
          prefixIcon: const Icon(Icons.search, color: AppColors.midGrey),
          suffixIcon: const Icon(Icons.filter_list, color: AppColors.midGrey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
  
  Widget _buildExploreCard() {
    // TODO: Implement navigation to Explore screen
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.orangeGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryOrange.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.explore, color: Colors.white, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Explore Turfs", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Find perfect venues nearby", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildUpcomingBookingCard() {
    // TODO: Fetch upcoming booking data dynamically
    // For now, using a placeholder until a booking is made
    return Container(
       // Card implementation as per design
       // Including the TimerBuilder for the countdown
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
          const Text("See All", style: TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildSportsCategories() {
    // TODO: Fetch categories and handle selection state
    final categories = ["All Sports", "Cricket", "Football", "Badminton"];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryNavy : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                categories[index],
                style: TextStyle(color: isSelected ? Colors.white : AppColors.darkGrey, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedTurfs() {
    // This would be a ListView of TurfCard widgets
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text("Featured Turfs List will be here..."),
    );
  }
}