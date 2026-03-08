import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../core/constants/api_urls.dart';

class ApiService {
  static Future<Map<String, String>> _headers() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  static Future<dynamic> getRequest(String url) async {
    final headers = await _headers();

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    return jsonDecode(response.body);
  }

  static Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    final headers = await _headers();

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }
}