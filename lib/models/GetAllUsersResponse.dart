class GetAllUsersResponse {
  final List<User> message;
  final int status;

  GetAllUsersResponse({
    required this.message,
    required this.status,
  });

  factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) {
    return GetAllUsersResponse(
      message: (json['message'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message.map((e) => e.toJson()).toList(),
      'status': status,
    };
  }
}

class User {
  final String address;
  final int block;
  final String dateOfAccountCreation;
  final String email;
  final int id;
  final int isApproved;
  final String name;
  final String password;
  final String phoneNumber;
  final String pinCode;
  final String userId;

  User({
    required this.address,
    required this.block,
    required this.dateOfAccountCreation,
    required this.email,
    required this.id,
    required this.isApproved,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.pinCode,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json['address'] as String,
      block: json['block'] as int,
      dateOfAccountCreation: json['date_of_account_creation'] as String,
      email: json['email'] as String,
      id: json['id'] as int,
      isApproved: json['isApproved'] as int,
      name: json['name'] as String,
      password: json['password'] as String,
      phoneNumber: json['phone_number'] as String,
      pinCode: json['pin_code'] as String,
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'block': block,
      'date_of_account_creation': dateOfAccountCreation,
      'email': email,
      'id': id,
      'isApproved': isApproved,
      'name': name,
      'password': password,
      'phone_number': phoneNumber,
      'pin_code': pinCode,
      'user_id': userId,
    };
  }
}
