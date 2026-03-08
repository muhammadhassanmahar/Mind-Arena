import '../services/api_service.dart';
import '../core/constants/api_urls.dart';

class ContestService {

  Future<dynamic> getTodayContests() async {
    return await ApiService.getRequest(
      ApiUrls.getContests,
    );
  }

  Future<dynamic> joinContest(String contestId) async {
    return await ApiService.postRequest(
      ApiUrls.joinContest,
      {
        "contest_id": contestId,
      },
    );
  }

  Future<dynamic> submitResult({
    required String contestId,
    required int solveTime,
  }) async {
    return await ApiService.postRequest(
      ApiUrls.submitResult,
      {
        "contest_id": contestId,
        "solve_time": solveTime,
      },
    );
  }

  Future<dynamic> getLeaderboard(String contestId) async {
    return await ApiService.getRequest(
      "${ApiUrls.leaderboard}?contest_id=$contestId",
    );
  }
}