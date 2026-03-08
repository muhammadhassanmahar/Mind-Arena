class LeaderboardModel {
  final int rank;
  final String name;
  final int solveTime;
  final double prize;

  LeaderboardModel({
    required this.rank,
    required this.name,
    required this.solveTime,
    required this.prize,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      rank: json["rank"] ?? 0,
      name: json["name"] ?? "",
      solveTime: json["solve_time"] ?? 0,
      prize: (json["prize"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rank": rank,
      "name": name,
      "solve_time": solveTime,
      "prize": prize,
    };
  }
}