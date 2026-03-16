import 'package:flutter/material.dart';
import '../services/contest_service.dart';
import '../models/contest_model.dart';
import '../models/leaderboard_model.dart';

class ContestProvider extends ChangeNotifier {

  final ContestService _contestService = ContestService();

  bool _isLoading = false;

  List<ContestModel> _contests = [];
  List<LeaderboardModel> _leaderboard = [];

  bool get isLoading => _isLoading;
  List<ContestModel> get contests => _contests;
  List<LeaderboardModel> get leaderboard => _leaderboard;

  Future<void> fetchContests() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _contestService.getTodayContests();

      // Backend returns single contest object
      if (response != null) {
        _contests = [ContestModel.fromJson(response)];
      } else {
        _contests = [];
      }

      _isLoading = false;
      notifyListeners();

    } catch (e) {

      _contests = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> joinContest(String contestId) async {
    try {

      await _contestService.joinContest(contestId);

      return true;

    } catch (e) {

      return false;
    }
  }

  Future<void> submitResult({
    required String contestId,
    required int solveTime,
  }) async {

    await _contestService.submitResult(
      contestId: contestId,
      solveTime: solveTime,
    );
  }

  Future<void> fetchLeaderboard(String contestId) async {

    try {

      _isLoading = true;
      notifyListeners();

      final response = await _contestService.getLeaderboard(contestId);

      _leaderboard = (response as List)
          .map((e) => LeaderboardModel.fromJson(e))
          .toList();

      _isLoading = false;
      notifyListeners();

    } catch (e) {

      _leaderboard = [];
      _isLoading = false;
      notifyListeners();
    }
  }
}