// lib/screens/explore/widgets/city_selection_modal.dart

import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class CitySelectionModal extends StatelessWidget {
  final List<String> cities;
  final Function(String) onCitySelected;

  const CitySelectionModal({
    Key? key,
    required this.cities,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select Your City', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: AppColors.midGrey)),
            ],
          ),
          const Text('Choose your location', style: TextStyle(color: AppColors.midGrey)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: AppColors.midGrey),
                  title: Text(cities[index]),
                  onTap: () {
                    onCitySelected(cities[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}