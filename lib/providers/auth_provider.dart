import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    // TODO: call backend
    await Future.delayed(const Duration(milliseconds: 600));
    _token = 'dummy';
    final sp = await SharedPreferences.getInstance();
    await sp.setString('token', _token!);
    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String state,
    required String city,
    required String preferredSport,
  }) async {
    // TODO: call backend
    await Future.delayed(const Duration(milliseconds: 800));
    return true;
  }

  Future<void> logout() async {
    _token = null;
    final sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    notifyListeners();
  }
}
