// lib/screens/bookings/bookings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/booking.dart';
import '../../providers/bookings_provider.dart';
import '../../utils/colors.dart';
import '../../utils/gradiants.dart';
import 'widgets/booking_card.dart'; // We will create this next

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BookingsProvider(),
      child: Consumer<BookingsProvider>(
        builder: (context, provider, _) {
          final bookings = provider.filteredBookings;
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, provider),
                  _buildQuickFilters(context, provider),
                  _buildStatsSection(context, provider),
                  Expanded(
                    child: bookings.isEmpty
                        ? const Center(child: Text("No bookings found for this filter."))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            itemCount: bookings.length,
                            itemBuilder: (ctx, i) => BookingCard(booking: bookings[i]),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, BookingsProvider provider) {
    final count = provider.filteredBookings.length;
    final statusText = provider.selectedStatus.name;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(gradient: AppGradients.headerGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          Column(
            children: [
              const Text('My Bookings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
              Text('$count $statusText booking${count != 1 ? 's' : ''}', style: const TextStyle(color: AppColors.midGrey)),
            ],
          ),
          const CircleAvatar(backgroundColor: AppColors.primaryOrange, child: Icon(Icons.add, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildQuickFilters(BuildContext context, BookingsProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilterChip(label: const Text('All'), selected: provider.selectedTimeFilter == TimeFilter.all, onSelected: (val) => provider.selectTimeFilter(TimeFilter.all)),
          FilterChip(label: const Text('Today'), selected: provider.selectedTimeFilter == TimeFilter.today, onSelected: (val) => provider.selectTimeFilter(TimeFilter.today)),
          FilterChip(label: const Text('This Week'), selected: provider.selectedTimeFilter == TimeFilter.week, onSelected: (val) => provider.selectTimeFilter(TimeFilter.week)),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, BookingsProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatCard(context, provider, BookingStatus.upcoming, Icons.access_time, AppColors.primaryNavy),
          const SizedBox(width: 12),
          _buildStatCard(context, provider, BookingStatus.completed, Icons.check_circle, AppColors.green),
          const SizedBox(width: 12),
          _buildStatCard(context, provider, BookingStatus.cancelled, Icons.cancel, AppColors.red),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, BookingsProvider provider, BookingStatus status, IconData icon, Color color) {
    final bool isActive = provider.selectedStatus == status;
    final count = provider.bookingCounts[status] ?? 0;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => provider.selectStatus(status),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isActive ? Border.all(color: color, width: 2) : null,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
          ),
          child: Column(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, size: 20, color: color)),
              const SizedBox(height: 8),
              Text('$count', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
              Text(status.name.capitalize(), style: const TextStyle(fontSize: 10, color: AppColors.midGrey)),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}