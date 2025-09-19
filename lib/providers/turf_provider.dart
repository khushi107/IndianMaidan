// lib/providers/turf_provider.dart
import 'package:flutter/material.dart';
import '../models/turf.dart';

class TurfProvider with ChangeNotifier {
  // TODO: Replace this with data from your backend
  final List<Turf> _turfs = [
    Turf(
      id: '1',
      name: 'City Arena Football',
      address: 'Shobhagpura, Udaipur',
      primaryImage: 'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg',
      galleryImages: [
        'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg',
        'https://images.pexels.com/photos/1171084/pexels-photo-1171084.jpeg',
        'https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg'
      ],
      startingRate: 1200,
      latitude: 24.613,
      longitude: 73.708,
      amenities: ['Parking', 'Drinking Water', 'Bibs', 'Washroom'],
    ),
    Turf(
      id: '2',
      name: 'Spartans Cricket Ground',
      address: 'Pratap Nagar, Udaipur',
      primaryImage: 'https://images.pexels.com/photos/163452/cricket-cricket-bat-ball-field-163452.jpeg',
      galleryImages: [],
      startingRate: 1500,
      latitude: 24.57,
      longitude: 73.74,
      amenities: ['Parking', 'Changing Room'],
    ),
  ];

  List<Turf> get turfs => _turfs;

  Turf findById(String id) {
    return _turfs.firstWhere((turf) => turf.id == id);
  }

  // TODO: Implement API call to fetch turfs
  Future<void> fetchTurfs(String location) async {
    // 1. Make HTTP request to your backend with the location query.
    // 2. Parse the JSON response into a List<Turf>.
    // 3. Update the _turfs list.
    // 4. Call notifyListeners() to update the UI.
    print('Fetching turfs for location: $location');
    notifyListeners();
  }

  // TODO: Implement API call to fetch a single turf's details
  Future<void> fetchTurfDetails(String turfId) async {
    print('Fetching details for turf ID: $turfId');
    // This method will be more useful when you fetch data,
    // as you might only have partial data on the home screen.
    notifyListeners();
  }
}