// lib/utils/gradients.dart

import 'package:flutter/material.dart';
//import 'colors.dart';

class AppGradients {
  /// The primary orange gradient used for buttons and hero cards.
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [
      Color(0xFFE65100), // Dark Orange
      Color(0xFFFF6F00), // Medium Orange
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// The light gray/blue gradient for headers.
  static const LinearGradient headerGradient = LinearGradient(
    colors: [
      Color(0xFFF8FAFC), // Very light blue-gray
      Color(0xFFF1F5F9), // Light blue-gray
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  /// Gradient for "Find Venues" quick action button.
  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF2563EB),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradient for "Favorites" quick action button.
  static const LinearGradient redGradient = LinearGradient(
    colors: [
      Color(0xFFEF4444),
      Color(0xFFDC2626),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradient for "Support" quick action button.
  static const LinearGradient greenGradient = LinearGradient(
    colors: [
      Color(0xFF10B981),
      Color(0xFF059669),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}