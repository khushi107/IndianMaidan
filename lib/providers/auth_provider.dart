import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  /// A getter to easily check if the user is truly authenticated.
  bool get isAuthenticated {
    return _token != null && _expiryDate != null && _expiryDate!.isAfter(DateTime.now());
  }

  /// Attempts to log the user in. Returns true on success, false on failure.
  Future<bool> login(String email, String password) async {
    try {
      // TODO: Replace this with your actual API call.
      await Future.delayed(const Duration(seconds: 1)); // Simulate network
      
      _token = 'dummy-auth-token-from-api';
      _userId = 'dummy-user-id';
      _expiryDate = DateTime.now().add(const Duration(days: 7));
      
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(), // Corrected spelling
      });
      await prefs.setString('userData', userData);
      
      return true; // Return true on success
    } catch (error) {
      print(error);
      return false; // Return false on failure
    }
  }

  /// Attempts to register a new user. Returns true on success, false on failure.
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String state,
    required String city,
    required String preferredSport,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (error) {
      print('Registration failed: $error');
      return false;
    }
  }
  
  /// Checks device storage for a valid token to automatically log the user in.
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    
    notifyListeners();
    return true;
  }

  /// Logs the user out and clears their data from the device.
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    notifyListeners();
  }
}