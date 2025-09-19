// lib/providers/explore_provider.dart

import 'package:flutter/material.dart';
import '../models/turf.dart'; // Assuming you have a Turf model

class ExploreProvider with ChangeNotifier {
  String? _selectedCity;
  
  // TODO: Fetch cities dynamically from your backend
  final List<String> _cities = [
    'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai', 'Kolkata'
  ];

  // TODO: Replace this with data fetched based on the selected city
  final List<Turf> _turfs = [
     Turf(
      id: '1',
      name: 'Tennis Academy',
      address: '321 Tennis Complex, Powai, Mumbai',
      primaryImage: 'https://images.pexels.com/photos/1432034/pexels-photo-1432034.jpeg',
      galleryImages: [],
      startingRate: 1000,
      latitude: 19.11, longitude: 72.90, amenities: [],
    ),
    // Add more dummy turfs...
  ];

  String? get selectedCity => _selectedCity;
  List<String> get cities => _cities;
  List<Turf> get turfs => _turfs;

  void selectCity(String city) {
    _selectedCity = city;
    // TODO: Trigger an API call to fetch turfs for the selected city
    print('City selected: $_selectedCity. Fetching turfs...');
    notifyListeners();
  }

  void clearCity() {
    _selectedCity = null;
    notifyListeners();
  }
}