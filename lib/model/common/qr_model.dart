class QrModel {
  String? merchantId;
  String? firstKey;
  String? lastKey;
  String? date;
  String? amount;
  String? itemId;
  String? description;
  String? lat;
  String? long;

  QrModel({
    this.merchantId,
    this.firstKey,
    this.lastKey,
    this.date,
    this.amount,
    this.itemId,
    this.description,
    this.lat,
    this.long,
  });

  Map<String, dynamic> toJson() => {
        'merchant_id': merchantId,
        'first_key': firstKey,
        'last_key': lastKey,
        'date': date,
        'amount': amount,
        'item_id': itemId,
        'description': description,
        'lat': lat,
        'long': long,
      };

  factory QrModel.fromJson(Map<String, dynamic> json) => QrModel(
        merchantId: json['merchant_id'],
        firstKey: json['first_key'],
        lastKey: json['last_key'],
        date: json['date'],
        amount: json['amount'],
        itemId: json['item_id'],
        description: json['description'],
        lat: json['lat'],
        long: json['long'],
      );
}
