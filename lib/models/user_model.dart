class UserModel {
  final String id;
  final String name;
  final String email;
  final double walletBalance;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.walletBalance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      walletBalance: (json["wallet_balance"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "wallet_balance": walletBalance,
    };
  }
}