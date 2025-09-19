// lib/widgets/turf_list_item.dart
import 'package:flutter/material.dart';
import '../models/turf.dart';
import '../screen/details/turf_details_screen.dart';
import '../utils/colors.dart';

class TurfListItem extends StatelessWidget {
  final Turf turf;

  const TurfListItem({Key? key, required this.turf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TurfDetailsScreen(turfId: turf.id),
        ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: AppColors.lightGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                turf.primaryImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turf.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.midGrey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        turf.address,
                        style: const TextStyle(color: AppColors.darkGrey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Starts at ₹${turf.startingRate}/hour',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}