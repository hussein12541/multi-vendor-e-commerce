import 'offer_product_model.dart';

class OfferModel {
  final String id;
  final String arabicName;
  final String englishName;
  final String imageUrl;
  final String deleteImageUrl;
  final DateTime createdAt;
  final List<OfferProductModel> offerProducts;

  OfferModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
    required this.imageUrl,
    required this.deleteImageUrl,
    required this.createdAt,
    required this.offerProducts,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      arabicName: json['arabic_name'],
      englishName: json['english_name'],
      imageUrl: json['image_url'],
      deleteImageUrl: json['delete_image_url'],
      createdAt: DateTime.parse(json['created_at']),
      offerProducts: (json['offer_products'] as List)
          .map((e) => OfferProductModel.fromJson(e))
          .toList(),
    );
  }
}
