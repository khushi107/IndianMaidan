// lib/screens/explore/widgets/empty_state_widget.dart

import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/gradiants.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onChooseCity;
  const EmptyStateWidget({Key? key, required this.onChooseCity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.orangeGradient,
            ),
            child: const Icon(Icons.location_on, color: Colors.white, size: 48),
          ),
          const SizedBox(height: 24),
          const Text(
            'Select Your City',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose your location to discover\namazing sports venues near you',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.midGrey, fontSize: 16),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: onChooseCity,
            icon: const Icon(Icons.location_city, color: Colors.white),
            label: const Text('Choose City', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              backgroundColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}