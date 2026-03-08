class ContestModel {
  final String id;
  final int entryFee;
  final int maxPlayers;
  final int playersJoined;
  final String status;
  final String startTime;
  final String puzzleImage;

  ContestModel({
    required this.id,
    required this.entryFee,
    required this.maxPlayers,
    required this.playersJoined,
    required this.status,
    required this.startTime,
    required this.puzzleImage,
  });

  factory ContestModel.fromJson(Map<String, dynamic> json) {
    return ContestModel(
      id: json["_id"] ?? "",
      entryFee: json["entry_fee"] ?? 0,
      maxPlayers: json["max_players"] ?? 20,
      playersJoined: json["players_joined"] ?? 0,
      status: json["status"] ?? "waiting",
      startTime: json["start_time"] ?? "",
      puzzleImage: json["puzzle_image"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "entry_fee": entryFee,
      "max_players": maxPlayers,
      "players_joined": playersJoined,
      "status": status,
      "start_time": startTime,
      "puzzle_image": puzzleImage,
    };
  }
}