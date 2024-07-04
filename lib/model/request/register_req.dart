class RegisterReq {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? type;

  RegisterReq({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.type,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'type': type,
      };

  factory RegisterReq.fromJson(Map<String, dynamic> json) => RegisterReq(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        type: json['type'],
      );
}
