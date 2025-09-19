// lib/screens/details/turf_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/turf.dart';
import '../../providers/turf_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_button.dart';

class TurfDetailsScreen extends StatefulWidget {
  final String turfId;
  const TurfDetailsScreen({Key? key, required this.turfId}) : super(key: key);

  @override
  State<TurfDetailsScreen> createState() => _TurfDetailsScreenState();
}

class _TurfDetailsScreenState extends State<TurfDetailsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedSlot;

  // TODO: Fetch available slots from backend for the selected date
  final List<String> _availableSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM', '03:00 PM', '05:00 PM', '06:00 PM'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final turf = Provider.of<TurfProvider>(context, listen: false).findById(widget.turfId);

    return Scaffold(
      appBar: AppBar(title: Text(turf.name, style: const TextStyle(color: AppColors.primaryNavy))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            if (turf.galleryImages.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(height: 250.0, autoPlay: true, viewportFraction: 1.0),
                items: turf.galleryImages.map((item) => Image.network(item, fit: BoxFit.cover, width: 1000)).toList(),
              )
            else
              Image.network(turf.primaryImage, height: 250, width: double.infinity, fit: BoxFit.cover),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(turf.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryNavy)),
                  const SizedBox(height: 8),
                  Text(turf.address, style: const TextStyle(fontSize: 16, color: AppColors.darkGrey)),
                  const SizedBox(height: 16),
                  
                  // Amenities
                  const Text('Amenities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: turf.amenities.map((amenity) => Chip(label: Text(amenity))).toList(),
                  ),
                  const Divider(height: 32),

                  // Booking Calendar
                  const Text('Select Date & Slot', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  _buildCalendar(),
                  const SizedBox(height: 16),

                  // Time Slots
                  _buildTimeSlots(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: 'Book Now (Pay 30% Advance)',
          onPressed: () {
            // TODO: Implement Razorpay payment flow
            // 1. Check if date and slot are selected.
            // 2. Call your backend to create a booking order and get a Razorpay order_id.
            // 3. Launch Razorpay checkout.
            if (_selectedDay != null && _selectedSlot != null) {
              print('Booking confirmed for $_selectedDay at $_selectedSlot');
              // Show confirmation dialog or navigate to a confirmation screen
            } else {
              // Show error message
            }
          },
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 60)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _selectedSlot = null; // Reset slot selection when date changes
            // TODO: Fetch slots for the new selectedDay from backend
          });
        },
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(color: AppColors.primaryOrange, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: AppColors.primaryNavy, shape: BoxShape.circle),
        ),
        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _availableSlots.map((slot) {
        final isSelected = _selectedSlot == slot;
        return ChoiceChip(
          label: Text(slot),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedSlot = selected ? slot : null;
            });
          },
          selectedColor: AppColors.primaryGreen,
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        );
      }).toList(),
    );
  }
}