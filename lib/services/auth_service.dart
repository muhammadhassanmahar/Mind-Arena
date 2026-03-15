import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../core/constants/api_urls.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Firebase Signup
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send user to backend
      try {
        await ApiService.postRequest(ApiUrls.createUser, {
          "name": name,
          "email": email,
          "uid": credential.user!.uid,
        });
      } catch (e) {
        debugPrint("Backend user creation failed: $e");
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase signup error: ${e.message}");
      rethrow;
    } catch (e) {
      debugPrint("Signup error: $e");
      rethrow;
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("Login error: ${e.message}");
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}