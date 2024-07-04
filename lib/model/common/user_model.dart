class UserModel {
  String? id;
  String? userPass;
  String? userEmail;
  String? userImage;
  String? firstName;
  String? lastName;
  String? userPhone;
  String? point;
  String? balance;
  String? country;
  String? address;
  String? state;
  String? postCode;

  UserModel({
    this.id,
    this.userPass,
    this.userEmail,
    this.userImage,
    this.firstName,
    this.lastName,
    this.userPhone,
    this.point,
    this.balance,
    this.country,
    this.address,
    this.state,
    this.postCode,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_password': userPass,
        'user_email': userEmail,
        'user_image': userImage,
        'user_first_name': firstName,
        'user_last_name': lastName,
        'user_phone': userPhone,
        'point': point,
        'balance': balance,
        'country': country,
        'address': address,
        'state': state,
        'postal_code': postCode,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        userPass: json['user_pass'],
        userEmail: json['user_email'],
        userImage: json['user_image'],
        firstName: json['user_first_name'],
        lastName: json['user_last_name'],
        userPhone: json['user_phone'],
        point: json['point'],
        balance: json['balance'],
        country: json['country'],
        address: json['address'],
        state: json['state'],
        postCode: json['postal_code'],
      );
}
