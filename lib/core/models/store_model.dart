import 'favorite_store_model.dart';

class StoreModel {
  final String id;
  final String arabic_name;
  final String english_name;
  final String imageUrl;
  final String description;
  final String? deleteImageUrl;
  final DateTime createdAt;
  final bool isShow;
  final String userId;
  final double rating;
  final int ratingCount;
  final double? userRating; // ✅ تقييم المستخدم الحالي
  final List<FavoriteStoreModel> favoriteStores;

  StoreModel({
    required this.id,
    required this.arabic_name,
    required this.english_name,
    required this.imageUrl,
    required this.description,
    required this.userId,
    required this.createdAt,
    required this.isShow,
    this.deleteImageUrl,
    required this.rating,
    required this.ratingCount,
    required this.userRating, // ✅
    required this.favoriteStores,
  });

  StoreModel copyWith({
    String? id,
    String? arabic_name,
    String? english_name,
    String? imageUrl,
    String? description,
    String? userId,
    DateTime? createdAt,
    bool? isShow,
    String? deleteImageUrl,
    double? rating,
    int? ratingCount,
    double? userRating,
    List<FavoriteStoreModel>? favoriteStores,
  }) {
    return StoreModel(
      id: id ?? this.id,
      arabic_name: arabic_name ?? this.arabic_name,
      english_name: english_name ?? this.english_name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      isShow: isShow ?? this.isShow,
      deleteImageUrl: deleteImageUrl ?? this.deleteImageUrl,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      userRating: userRating ?? this.userRating,
      favoriteStores: favoriteStores ?? this.favoriteStores,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic_name': arabic_name,
      'english_name': english_name,
      'image_url': imageUrl,
      'description': description,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'is_show': isShow,
      'delete_image_url': deleteImageUrl,
      // تقييم المستخدم الحالي والـrating العام مش بيتبعتوا، دول محسوبين
      // نفس الكلام على favoriteStores لأنه غالبًا علاقة خارجية
    };
  }


  factory StoreModel.fromJson(Map<String, dynamic> json, {required String currentUserId}) {
    final reviews = (json['store_reviews'] ?? []) as List;
    final ratingCount = reviews.length;

    double ratingSum = 0;
    double? userRating;

    for (var review in reviews) {
      final rating = (review['rating'] ?? 0).toDouble();
      ratingSum += rating;

      // ✅ جلب تقييم المستخدم الحالي
      if (review['user_id'] == currentUserId) {
        userRating = rating;
      }
    }

    final averageRating = ratingCount == 0
        ? 0.0
        : (ratingSum / ratingCount * 2).round() / 2;


    return StoreModel(
      id: json['id'] ?? '',
      arabic_name: json['arabic_name'] ?? '',
      english_name: json['english_name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      isShow: json['is_show'] ?? true,
      deleteImageUrl: json['delete_image_url'],
      rating: averageRating,
      ratingCount: ratingCount,
      userRating: userRating, // ✅
      favoriteStores: (json['favorites_stores'] as List?)
          ?.map((e) => FavoriteStoreModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}
