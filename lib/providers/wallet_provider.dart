import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../core/constants/api_urls.dart';
import '../models/wallet_model.dart';

class WalletProvider extends ChangeNotifier {

  bool _isLoading = false;
  WalletModel? _wallet;

  bool get isLoading => _isLoading;
  WalletModel? get wallet => _wallet;

  Future<void> fetchWallet() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await ApiService.getRequest(
        ApiUrls.wallet,
      );

      _wallet = WalletModel.fromJson(response);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deposit({
    required String name,
    required String email,
    required String screenshot,
  }) async {
    try {
      await ApiService.postRequest(
        ApiUrls.deposit,
        {
          "name": name,
          "email": email,
          "screenshot": screenshot,
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> withdraw({
    required String name,
    required String email,
    required double amount,
    required String accountType,
    required String accountNumber,
  }) async {
    try {
      await ApiService.postRequest(
        ApiUrls.withdraw,
        {
          "name": name,
          "email": email,
          "amount": amount,
          "account_type": accountType,
          "account_number": accountNumber,
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}