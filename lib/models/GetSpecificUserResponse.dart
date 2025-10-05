class GetSpecificUserResponse {
  final Message? message;
  final int? status;

  GetSpecificUserResponse({
    this.message,
    this.status,
  });

  factory GetSpecificUserResponse.fromJson(Map<String, dynamic> json) {
    return GetSpecificUserResponse(
      message: json['message'] != null
          ? Message.fromJson(json['message'])
          : null,
      status: json['status'] != null ? json['status'] as int : null,
    );
  }

  GetSpecificUserResponse copyWith({
    Message? message,
    int? status,
  }) {
    return GetSpecificUserResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['status'] = status;
    return map;
  }
}

class Message {
  final String? address;
  final int? block;
  final String? dateOfAccountCreation;
  final String? email;
  final int? id;
  final int? isApproved;
  final String? name;
  final String? password;
  final String? phoneNumber;
  final String? pinCode;
  final String? userId;

  Message({
    this.address,
    this.block,
    this.dateOfAccountCreation,
    this.email,
    this.id,
    this.isApproved,
    this.name,
    this.password,
    this.phoneNumber,
    this.pinCode,
    this.userId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      address: json['address'] as String?,
      block: json['block'] as int?,
      dateOfAccountCreation: json['date_of_account_creation'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      isApproved: json['isApproved'] as int?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      phoneNumber: json['phone_number'] as String?,
      pinCode: json['pin_code'] as String?,
      userId: json['user_id'] as String?,
    );
  }

  Message copyWith({
    String? address,
    int? block,
    String? dateOfAccountCreation,
    String? email,
    int? id,
    int? isApproved,
    String? name,
    String? password,
    String? phoneNumber,
    String? pinCode,
    String? userId,
  }) {
    return Message(
      address: address ?? this.address,
      block: block ?? this.block,
      dateOfAccountCreation: dateOfAccountCreation ?? this.dateOfAccountCreation,
      email: email ?? this.email,
      id: id ?? this.id,
      isApproved: isApproved ?? this.isApproved,
      name: name ?? this.name,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pinCode: pinCode ?? this.pinCode,
      userId: userId ?? this.userId,
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
