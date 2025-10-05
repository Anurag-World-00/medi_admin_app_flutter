import 'dart:convert';

/// Converts a JSON string into a [GetAllOrdersResponse] object.
GetAllOrdersResponse getAllOrdersResponseFromJson(String str) =>
    GetAllOrdersResponse.fromJson(json.decode(str));

/// Converts a [GetAllOrdersResponse] object into a JSON string.
String getAllOrdersResponseToJson(GetAllOrdersResponse data) =>
    json.encode(data.toJson());

class GetAllOrdersResponse {
  final List<OrderMessage> message;
  final int status;

  GetAllOrdersResponse({
    required this.message,
    required this.status,
  });

  factory GetAllOrdersResponse.fromJson(Map<String, dynamic> json) {
    return GetAllOrdersResponse(
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => OrderMessage.fromJson(e))
          .toList() ??
          [],
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message.map((e) => e.toJson()).toList(),
    'status': status,
  };
}

class OrderMessage {
  final String category;
  final String dateOfOrderCreation;
  final int id;
  final int isApproved;
  final String message;
  final String orderId;
  final num price;
  final String productId;
  final String productName;
  final int quantity;
  final num totalAmount;
  final String userId;
  final String userName;

  OrderMessage({
    required this.category,
    required this.dateOfOrderCreation,
    required this.id,
    required this.isApproved,
    required this.message,
    required this.orderId,
    required this.price,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalAmount,
    required this.userId,
    required this.userName,
  });

  factory OrderMessage.fromJson(Map<String, dynamic> json) {
    return OrderMessage(
      category: json['category'] ?? '',
      dateOfOrderCreation: json['date_of_order_creation'] ?? '',
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      isApproved: json['isApproved'] is int
          ? json['isApproved']
          : int.tryParse(json['isApproved'].toString()) ?? 0,
      message: json['message'] ?? '',
      orderId: json['order_id'] ?? '',
      price: json['price'] is num
          ? json['price']
          : num.tryParse(json['price'].toString()) ?? 0,
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 0,
      totalAmount: json['total_amount'] is num
          ? json['total_amount']
          : num.tryParse(json['total_amount'].toString()) ?? 0,
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
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
