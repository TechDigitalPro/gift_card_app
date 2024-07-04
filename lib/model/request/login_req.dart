class LoginReq {
  String? email;
  String? password;
  String? type;

  LoginReq({
    this.email,
    this.password,
    this.type,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'type': type,
      };

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        email: json['email'],
        password: json['password'],
        type: json['type'],
      );
}
