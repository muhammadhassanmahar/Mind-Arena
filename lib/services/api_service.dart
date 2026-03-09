import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  /// Returns headers with Firebase Auth token if user is logged in
  static Future<Map<String, String>> _headers() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = user != null ? await user.getIdToken() : null;

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  /// Generic GET request
  static Future<dynamic> getRequest(String url) async {
    final headers = await _headers();

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'GET request failed with status: ${response.statusCode}, body: ${response.body}');
    }
  }

  /// Generic POST request with JSON body
  static Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    final headers = await _headers();

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'POST request failed with status: ${response.statusCode}, body: ${response.body}');
    }
  }

  /// Optional: PUT request
  static Future<dynamic> putRequest(String url, Map<String, dynamic> data) async {
    final headers = await _headers();

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'PUT request failed with status: ${response.statusCode}, body: ${response.body}');
    }
  }

  /// Optional: DELETE request
  static Future<dynamic> deleteRequest(String url) async {
    final headers = await _headers();

    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'DELETE request failed with status: ${response.statusCode}, body: ${response.body}');
    }
  }
}