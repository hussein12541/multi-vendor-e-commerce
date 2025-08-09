class CategoryModel {
  final String id;
  final String arabicName;
  final String englishName;
  final String imageUrl;
  final DateTime createdAt;
  final bool isShow;

  CategoryModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
    required this.imageUrl,
    required this.createdAt,
    required this.isShow,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      arabicName: json['arabic_name'] as String,
      englishName: json['english_name'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isShow: json['is_show'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic_name': arabicName,
      'english_name': englishName,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'is_show': isShow,
    };
  }
}
