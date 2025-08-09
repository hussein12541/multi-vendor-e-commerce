import '../../../../../core/models/product_model.dart';

class OfferProductModel {
  final String id;
  final String offerId;
  final String productId;
  final DateTime createdAt;
  final ProductModel product;

  OfferProductModel({
    required this.id,
    required this.offerId,
    required this.productId,
    required this.createdAt,
    required this.product,
  });

  factory OfferProductModel.fromJson(Map<String, dynamic> json) {
    return OfferProductModel(
      id: json['id'],
      offerId: json['offer_id'],
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
      product: ProductModel.fromJson(json['products']),
    );
  }
}
