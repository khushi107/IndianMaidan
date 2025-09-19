import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import '../../../models/booking.dart';
import '../../../utils/colors.dart';
import '../../../utils/gradiants.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({Key? key, required this.booking}) : super(key: key);

  // Helper to get status-specific color
  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return AppColors.primaryNavy;
      case BookingStatus.completed:
        return AppColors.green;
      case BookingStatus.cancelled:
        return AppColors.red;
    }
  }

  // Helper to get sport-specific icon
  IconData _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'cricket':
        return Icons.sports_cricket;
      case 'badminton':
      case 'tennis':
        return Icons.sports_tennis;
      default:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _buildCardHeader(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCardContent(),
                const SizedBox(height: 12),
                _buildPricingSection(),
                const SizedBox(height: 16),
                _buildActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context) {
    final statusColor = _getStatusColor(booking.status);
    bool isToday = DateUtils.isSameDay(booking.startTime, DateTime.now());

    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: statusColor, width: 2),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.network(
              booking.turfImage,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.image_not_supported),
            ),
          ),
          // Gradient overlay for text readability
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Status Badge
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                booking.status.name.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Today Badge
          if (isToday && booking.status == BookingStatus.upcoming)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Today", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ),
          // Turf Name and Address
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.turfName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(booking.turfAddress, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    bool isToday = DateUtils.isSameDay(booking.startTime, DateTime.now());
    return Column(
      children: [
        // Sport & Duration Row
        Row(
          children: [
            _buildInfoBox(icon: _getSportIcon(booking.sport), title: "SPORT", value: booking.sport),
            const SizedBox(width: 12),
            _buildInfoBox(icon: Icons.access_time, title: "DURATION", value: booking.duration),
          ],
        ),
        const SizedBox(height: 12),
        // Date & Time Row
        Row(
          children: [
            _buildInfoBox(icon: Icons.calendar_today, title: "DATE", value: DateFormat.yMMMd().format(booking.startTime)),
            const SizedBox(width: 12),
            _buildInfoBox(icon: Icons.watch_later_outlined, title: "TIME", value: DateFormat.jm().format(booking.startTime)),
          ],
        ),
        // Countdown Timer
        if (isToday && booking.status == BookingStatus.upcoming && booking.startTime.isAfter(DateTime.now()))
          TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (context) {
              final remaining = booking.startTime.difference(DateTime.now());
              return Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFFE0B2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined, color: AppColors.primaryOrange, size: 18),
                    const SizedBox(width: 8),
                    const Text("Starts in ", style: TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold)),
                    Text(
                      '${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildInfoBox({required IconData icon, required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.midGrey, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10, color: AppColors.midGrey, fontWeight: FontWeight.w500)),
                Text(value, style: const TextStyle(fontSize: 12, color: AppColors.darkGrey, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingSection() {
    final atTurfAmount = booking.totalPrice - booking.advancePaid;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("TOTAL", style: TextStyle(fontSize: 11, color: AppColors.midGrey)),
              Text("₹${booking.totalPrice.toInt()}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkGrey)),
            ],
          ),
          Row(
            children: [
              _buildPaymentDetail("PAID", booking.advancePaid, AppColors.green),
              Container(width: 1, height: 24, color: AppColors.border, margin: const EdgeInsets.symmetric(horizontal: 12)),
              _buildPaymentDetail("AT TURF", atTurfAmount, AppColors.yellow),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetail(String label, double amount, Color dotColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("₹${amount.toInt()}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.midGrey)),
            const SizedBox(width: 4),
            Icon(Icons.circle, color: dotColor, size: 8),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    switch (booking.status) {
      case BookingStatus.upcoming:
        return Row(children: [
          Expanded(child: _buildButton(text: "Reschedule", isPrimary: false)),
          const SizedBox(width: 12),
          Expanded(child: _buildButton(text: "Cancel", isPrimary: false, isDestructive: true)),
        ]);
      case BookingStatus.completed:
        return Row(children: [
          Expanded(child: _buildButton(text: "Book Again", isPrimary: false)),
          const SizedBox(width: 12),
          Expanded(child: _buildButton(text: "Review", isPrimary: true, gradient: AppGradients.greenGradient)),
        ]);
      case BookingStatus.cancelled:
        return _buildButton(text: "Book Again", isPrimary: true, gradient: AppGradients.orangeGradient);
    }
  }

  Widget _buildButton({required String text, bool isPrimary = false, bool isDestructive = false, Gradient? gradient}) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        gradient: isPrimary ? gradient : null,
        color: isPrimary ? null : (isDestructive ? AppColors.red.withOpacity(0.1) : AppColors.background),
        borderRadius: BorderRadius.circular(10),
        border: isPrimary ? null : Border.all(color: isDestructive ? AppColors.red.withOpacity(0.3) : AppColors.border),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Colors.white : (isDestructive ? AppColors.red : AppColors.midGrey),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}