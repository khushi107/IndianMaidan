import 'package:flutter/material.dart';
import '../../../models/turf.dart';
import '../../../utils/colors.dart';
import '../../../utils/gradiants.dart';

class ExploreTurfCard extends StatelessWidget {
  final Turf turf;
  const ExploreTurfCard({Key? key, required this.turf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: AppColors.lightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          _buildContentSection(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Main Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            turf.primaryImage,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // Gradient Overlay
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Sport Badge (Top-Left)
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              gradient: AppGradients.orangeGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "TENNIS", // TODO: Make this dynamic from turf data
              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Availability Badge (Top-Right)
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "AVAILABLE", // TODO: Make this dynamic
              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Price Tag (Bottom-Left)
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppGradients.blueGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "₹${turf.startingRate.toInt()}/hour",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Turf Name and Verified Badge
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(turf.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text("VERIFIED", style: TextStyle(color: AppColors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              // Favorite Icon
              IconButton(onPressed: () { /* TODO: Add to favorites logic */ }, icon: const Icon(Icons.favorite_border, color: AppColors.red)),
            ],
          ),
          const SizedBox(height: 12),
          // Location
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.midGrey, size: 16),
              const SizedBox(width: 8),
              Expanded(child: Text(turf.address, style: const TextStyle(color: AppColors.midGrey))),
            ],
          ),
          const Divider(height: 24),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () { /* TODO: Implement View on Map */ },
                  icon: const Icon(Icons.map_outlined),
                  label: const Text("View Map"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () { /* TODO: Navigate to Turf Details Screen */ },
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const Text("Book Now"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryOrange,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}