import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://your-api-url.com/api'; // Replace with actual API URL
  
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  static Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
