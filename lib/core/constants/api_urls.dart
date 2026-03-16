class ApiUrls {

  static const String baseUrl = "http://localhost:8000";

  // AUTH
  static const String createUser = "$baseUrl/user/create";

  // CONTESTS
  static const String getContests = "$baseUrl/contests/today";
  static const String joinContest = "$baseUrl/contest/join";
  static const String submitResult = "$baseUrl/contest/submit";
  static const String leaderboard = "$baseUrl/contest/leaderboard";

  // WALLET
  static const String wallet = "$baseUrl/wallet";
  static const String deposit = "$baseUrl/deposit";
  static const String withdraw = "$baseUrl/withdraw";

}