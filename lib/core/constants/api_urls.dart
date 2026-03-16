class ApiUrls {

  static const String baseUrl = "http://127.0.0.1:8000";

  // ================= AUTH =================
  static const String createUser = "$baseUrl/auth/signup";
  static const String login = "$baseUrl/auth/login";

  // ================= CONTEST =================
  static const String getTodayContest = "$baseUrl/contest/today";
  static const String getAllContests = "$baseUrl/contest";

  // ================= LEADERBOARD =================
  static const String leaderboard = "$baseUrl/contest/leaderboard";

  // ================= WALLET =================
  static const String wallet = "$baseUrl/wallet";
}