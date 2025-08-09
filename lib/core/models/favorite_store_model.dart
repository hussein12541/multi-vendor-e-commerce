class FavoriteStoreModel {
  final String id;
  final String userId;
  final String storeId;
  final DateTime createdAt;

  FavoriteStoreModel({
    required this.id,
    required this.userId,
    required this.storeId,
    required this.createdAt,
  });

  factory FavoriteStoreModel.fromJson(Map<String, dynamic> json) {
    return FavoriteStoreModel(
      id: json['id'],
      userId: json['user_id'],
      storeId: json['store_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
