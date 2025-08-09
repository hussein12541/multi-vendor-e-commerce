class RateModel {
  final String id;
  final double rate;
  final String userId;
  final String productId;
  final DateTime createdAt;

  RateModel({
    required this.id,
    required this.rate,
    required this.userId,
    required this.productId,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rate': rate,
      'user_id': userId,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
    };
  }


  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      rate: (json['rate'] as num).toDouble(),
      userId: json['user_id'],
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
