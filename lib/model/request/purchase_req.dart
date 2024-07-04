class PurchaseReq {
  String? businessId;
  String? firstKey;
  String? lastKey;
  String? date;
  String? amount;
  String? itemId;
  String? description;
  String? lat;
  String? long;
  String? consumerId;
  String? email;

  PurchaseReq({
    this.businessId,
    this.firstKey,
    this.lastKey,
    this.date,
    this.amount,
    this.itemId,
    this.description,
    this.lat,
    this.long,
    this.consumerId,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'merchant_id': businessId,
        'first_key': firstKey,
        'last_key': lastKey,
        'date': date,
        'amount': amount,
        'item_id': itemId,
        'description': description,
        'lat': lat,
        'long': long,
        'consumer_id': consumerId,
        'email': email,
      };

  factory PurchaseReq.fromJson(Map<String, dynamic> json) => PurchaseReq(
        businessId: json['merchant_id'],
        firstKey: json['first_key'],
        lastKey: json['last_key'],
        date: json['date'],
        amount: json['amount'],
        itemId: json['item_id'],
        description: json['description'],
        lat: json['lat'],
        long: json['long'],
        consumerId: json['consumer_id'],
        email: json['email'],
      );
}
