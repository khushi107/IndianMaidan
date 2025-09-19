// lib/models/booking.dart

// CHANGE THE ENUM DEFINITION HERE
enum BookingStatus { upcoming, completed, cancelled } // <-- Use two 'L's

class Booking {
  final String id;
  final String turfName;
  final String turfImage;
  final String turfAddress;
  final String sport;
  final String duration;
  final DateTime startTime;
  final double totalPrice;
  final double advancePaid;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.turfName,
    required this.turfImage,
    required this.turfAddress,
    required this.sport,
    required this.duration,
    required this.startTime,
    required this.totalPrice,
    required this.advancePaid,
    required this.status,
  });
}