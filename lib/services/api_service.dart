import 'dart:convert';
import 'package:flutter/foundation.dart';
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
    try {
      final headers = await _headers();

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      debugPrint("GET: $url");
      debugPrint("Status: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "GET request failed: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("GET ERROR: $e");
      rethrow;
    }
  }

  /// Generic POST request with JSON body
  static Future<dynamic> postRequest(
      String url, Map<String, dynamic> data) async {
    try {
      final headers = await _headers();

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      debugPrint("POST: $url");
      debugPrint("Status: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "POST request failed: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("POST ERROR: $e");
      rethrow;
    }
  }

  /// PUT request
  static Future<dynamic> putRequest(
      String url, Map<String, dynamic> data) async {
    try {
      final headers = await _headers();

      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      debugPrint("PUT: $url");
      debugPrint("Status: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "PUT request failed: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("PUT ERROR: $e");
      rethrow;
    }
  }

  /// DELETE request
  static Future<dynamic> deleteRequest(String url) async {
    try {
      final headers = await _headers();

      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );

      debugPrint("DELETE: $url");
      debugPrint("Status: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "DELETE request failed: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("DELETE ERROR: $e");
      rethrow;
    }
  }
}