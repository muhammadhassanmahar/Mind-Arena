import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

// import '../core/constants/api_urls.dart'; // ✅ Unused import removed

class ApiService {
  static Future<Map<String, String>> _headers() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    return {
      "Content-Type": "application/json",
      "Authorization": token != null ? "Bearer $token" : "",
    };
  }

  static Future<dynamic> getRequest(String url) async {
    final headers = await _headers();

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET request failed with status: ${response.statusCode}');
    }
  }

  static Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    final headers = await _headers();

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('POST request failed with status: ${response.statusCode}');
    }
  }
}