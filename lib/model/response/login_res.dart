import 'package:gift_card/model/common/user_model.dart';

class LoginRes {
  bool? status;
  String? apiVersion;
  String? message;
  String? token;
  UserModel? user;

  LoginRes({
    this.status,
    this.apiVersion,
    this.message,
    this.token,
    this.user,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'api_version': apiVersion,
        'message': message,
        'token': token,
        'user': user == null ? null : user!.toJson(),
      };

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        status: json['status'],
        apiVersion: json['api_version'],
        message: json['message'],
        token: json['token'],
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      );
}
