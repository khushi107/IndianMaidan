// lib/models/turf.dart
class Turf {
  final String id;
  final String name;
  final String address;
  final String primaryImage;
  final List<String> galleryImages;
  final double startingRate;
  final double latitude;
  final double longitude;
  final List<String> amenities;

  Turf({
    required this.id,
    required this.name,
    required this.address,
    required this.primaryImage,
    required this.galleryImages,
    required this.startingRate,
    required this.latitude,
    required this.longitude,
    required this.amenities,
  });
}