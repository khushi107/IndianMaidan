// lib/screens/explore/explore_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/explore_provider.dart';
import '../../utils/colors.dart';
import 'widgets/city_selection_modal.dart';
import 'widgets/empty_state_widget.dart';
import 'widgets/explore_turf_card.dart';
// TODO: Create and import ExploreTurfCard widget
// import 'widgets/explore_turf_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  void _showCitySelection(BuildContext context, ExploreProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: CitySelectionModal(
          cities: provider.cities,
          onCitySelected: (city) {
            provider.selectCity(city);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ExploreProvider(),
      child: Consumer<ExploreProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('Explore Turfs', style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            body: provider.selectedCity == null
                ? EmptyStateWidget(onChooseCity: () => _showCitySelection(context, provider))
                : _buildResultsView(context, provider),
          );
        },
      ),
    );
  }

  Widget _buildResultsView(BuildContext context, ExploreProvider provider) {
      // List of turfs
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: provider.turfs.length,
            itemBuilder: (ctx, index) {
              // --- REPLACE THE OLD CARD WITH THIS ---
              return ExploreTurfCard(turf: provider.turfs[index]);
              // ------------------------------------
            },
          ),
        );
    return Column(
      children: [
        // Header with city and search
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showCitySelection(context, provider),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.primaryOrange, size: 18),
                    const SizedBox(width: 8),
                    Text(provider.selectedCity!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryOrange)),
                    const Icon(Icons.arrow_drop_down, color: AppColors.primaryOrange),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const TextField(decoration: InputDecoration(hintText: 'Search turfs, sports...', prefixIcon: Icon(Icons.search))),
            ],
          ),
        ),
        // Results count and filter button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${provider.turfs.length} turfs found in ${provider.selectedCity}', style: const TextStyle(color: AppColors.midGrey)),
              OutlinedButton.icon(
                onPressed: () { /* TODO: Show filters modal */ },
                icon: const Icon(Icons.filter_list),
                label: const Text('Filters'),
              ),
            ],
          ),
        ),
        // List of turfs
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: provider.turfs.length,
            itemBuilder: (ctx, index) {
              // TODO: Replace with the new ExploreTurfCard widget
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(provider.turfs[index].name),
                  subtitle: Text(provider.turfs[index].address),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}