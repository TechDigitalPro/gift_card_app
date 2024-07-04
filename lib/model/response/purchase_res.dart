import 'package:gift_card/model/common/user_model.dart';

class PurchaseRes {
  bool? status;
  String? apiVersion;
  String? message;
  UserModel? user;

  PurchaseRes({
    this.status,
    this.apiVersion,
    this.message,
    this.user,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'api_version': apiVersion,
        'message': message,
        'user': user == null ? null : user!.toJson(),
      };

  factory PurchaseRes.fromJson(Map<String, dynamic> json) => PurchaseRes(
        status: json['status'],
        apiVersion: json['api_version'],
        message: json['message'],
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      );
}
