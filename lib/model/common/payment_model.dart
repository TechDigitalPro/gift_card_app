class PaymentModel {
  String? newPoint;
  String? earnedPoint;
  String? oldPoint;
  String? startBalance;
  String? newBalance;
  String? amount;
  String? receiptUrl;
  String? description;

  PaymentModel({
    this.newPoint,
    this.earnedPoint,
    this.oldPoint,
    this.startBalance,
    this.newBalance,
    this.amount,
    this.receiptUrl,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'new_point': newPoint,
        'earned_point': earnedPoint,
        'old_point': oldPoint,
        'start_balance': startBalance,
        'new_balance': newBalance,
        'amount': amount,
        'receipt_url': receiptUrl,
        'description': description,
      };

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        newPoint: json['new_point'],
        earnedPoint: json['earned_point'],
        oldPoint: json['old_point'],
        startBalance: json['start_balance'],
        newBalance: json['new_balance'],
        amount: json['amount'],
        receiptUrl: json['receipt_url'],
        description: json['description'],
      );
}
