class WalletModel {
  final double balance;
  final List transactions;

  WalletModel({
    required this.balance,
    required this.transactions,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: (json["balance"] ?? 0).toDouble(),
      transactions: json["transactions"] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balance": balance,
      "transactions": transactions,
    };
  }
}