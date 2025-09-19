// lib/providers/bookings_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/booking.dart';

enum TimeFilter { all, today, week }

class BookingsProvider with ChangeNotifier {
  BookingStatus _selectedStatus = BookingStatus.upcoming;
  TimeFilter _selectedTimeFilter = TimeFilter.all;

  // TODO: Replace this with data from your backend API
  final List<Booking> _allBookings = [
    // Upcoming
    Booking(id: '1', turfName: 'Elite Football Arena', turfAddress: 'Sector 18, Noida', sport: 'Football', duration: '2 hours', startTime: DateTime.now().add(const Duration(hours: 2, minutes: 39)), totalPrice: 1200, advancePaid: 360, status: BookingStatus.upcoming, turfImage: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400'),
    Booking(id: '2', turfName: 'Tennis Academy', turfAddress: 'Powai, Mumbai', sport: 'Tennis', duration: '1 hour', startTime: DateTime.now().add(const Duration(days: 3)), totalPrice: 700, advancePaid: 210, status: BookingStatus.upcoming, turfImage: 'https://images.pexels.com/photos/1432034/pexels-photo-1432034.jpeg'),
    
    // Completed
    Booking(id: '3', turfName: 'Cricket Stadium Pro', turfAddress: 'Andheri East, Mumbai', sport: 'Cricket', duration: '2 hours', startTime: DateTime.now().subtract(const Duration(days: 2)), totalPrice: 800, advancePaid: 240, status: BookingStatus.completed, turfImage: 'https://images.pexels.com/photos/220325/pexels-photo-220325.jpeg'),
    
    // Cancelled
    Booking(id: '4', turfName: 'Badminton Court Elite', turfAddress: 'Bandra West, Mumbai', sport: 'Badminton', duration: '1 hour', startTime: DateTime.now().subtract(const Duration(days: 5)), totalPrice: 400, advancePaid: 100, status: BookingStatus.cancelled, turfImage: 'https://images.pexels.com/photos/6203520/pexels-photo-6203520.jpeg'),
  ];
  
  List<Booking> get filteredBookings {
    DateTime now = DateTime.now();
    return _allBookings.where((booking) {
      // Status Filter
      if (booking.status != _selectedStatus) return false;

      // Time Filter
      switch (_selectedTimeFilter) {
        case TimeFilter.today:
          return booking.startTime.year == now.year && booking.startTime.month == now.month && booking.startTime.day == now.day;
        case TimeFilter.week:
          return booking.startTime.isAfter(now.subtract(const Duration(days: 7))) && booking.startTime.isBefore(now.add(const Duration(days: 1)));
        case TimeFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  BookingStatus get selectedStatus => _selectedStatus;
  TimeFilter get selectedTimeFilter => _selectedTimeFilter;
  
  Map<BookingStatus, int> get bookingCounts {
    return {
      BookingStatus.upcoming: _allBookings.where((b) => b.status == BookingStatus.upcoming).length,
      BookingStatus.completed: _allBookings.where((b) => b.status == BookingStatus.completed).length,
      BookingStatus.cancelled: _allBookings.where((b) => b.status == BookingStatus.cancelled).length,
    };
  }

  void selectStatus(BookingStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void selectTimeFilter(TimeFilter filter) {
    _selectedTimeFilter = filter;
    notifyListeners();
  }
  
  // TODO: Implement API call to fetch bookings
  Future<void> fetchAndSetBookings() async {
    // 1. Make HTTP request.
    // 2. Parse the JSON response into a List<Booking>.
    // 3. Update _allBookings list.
    // 4. Call notifyListeners().
    notifyListeners();
  }
}