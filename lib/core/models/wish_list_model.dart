class WishlistModel {
  final String id;
  final String userId;
  final String productId;
  final DateTime createdAt;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}