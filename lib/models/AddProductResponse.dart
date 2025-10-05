class AddProductResponse {
  final String message;
  final int status;

  AddProductResponse({
    required this.message,
    required this.status,
  });

  // Copy with method
  AddProductResponse copyWith({
    String? message,
    int? status,
  }) {
    return AddProductResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  // JSON deserialization
  factory AddProductResponse.fromJson(Map<String, dynamic> json) {
    return AddProductResponse(
      message: json['message'] as String,
      status: json['status'] is int
          ? json['status'] as int
          : (json['status'] as num).toInt(),
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }

  @override
  String toString() => 'AddProductResponse(message: $message, status: $status)';
}
