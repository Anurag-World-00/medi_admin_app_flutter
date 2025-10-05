class GetSpecificOrderModel {
  final Message? message;
  final int? status;

  GetSpecificOrderModel({
    this.message,
    this.status,
  });

  factory GetSpecificOrderModel.fromJson(Map<String, dynamic> json) {
    return GetSpecificOrderModel(
      message: json['message'] != null
          ? Message.fromJson(json['message'])
          : null,
      status: json['status'] != null ? json['status'] as int : null,
    );
  }

  GetSpecificOrderModel copyWith({
    Message? message,
    int? status,
  }) {
    return GetSpecificOrderModel(
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
  final String? category;
  final String? dateOfOrderCreation;
  final int? id;
  final int? isApproved;
  final String? message;
  final String? orderId;
  final double? price;
  final String? productId;
  final String? productName;
  final int? quantity;
  final double? totalAmount;
  final String? userId;
  final String? userName;

  Message({
    this.category,
    this.dateOfOrderCreation,
    this.id,
    this.isApproved,
    this.message,
    this.orderId,
    this.price,
    this.productId,
    this.productName,
    this.quantity,
    this.totalAmount,
    this.userId,
    this.userName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      category: json['category'] as String?,
      dateOfOrderCreation: json['date_of_order_creation'] as String?,
      id: json['id'] as int?,
      isApproved: json['isApproved'] as int?,
      message: json['message'] as String?,
      orderId: json['order_id'] as String?,
      price: (json['price'] != null)
          ? (json['price'] as num).toDouble()
          : null,
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      quantity: json['quantity'] as int?,
      totalAmount: (json['total_amount'] != null)
          ? (json['total_amount'] as num).toDouble()
          : null,
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
    );
  }

  Message copyWith({
    String? category,
    String? dateOfOrderCreation,
    int? id,
    int? isApproved,
    String? message,
    String? orderId,
    double? price,
    String? productId,
    String? productName,
    int? quantity,
    double? totalAmount,
    String? userId,
    String? userName,
  }) {
    return Message(
      category: category ?? this.category,
      dateOfOrderCreation: dateOfOrderCreation ?? this.dateOfOrderCreation,
      id: id ?? this.id,
      isApproved: isApproved ?? this.isApproved,
      message: message ?? this.message,
      orderId: orderId ?? this.orderId,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'date_of_order_creation': dateOfOrderCreation,
      'id': id,
      'isApproved': isApproved,
      'message': message,
      'order_id': orderId,
      'price': price,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'total_amount': totalAmount,
      'user_id': userId,
      'user_name': userName,
    };
  }
}
