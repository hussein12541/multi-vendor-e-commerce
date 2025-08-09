
import '../../../../../core/models/product_model.dart';

class CartItemModel {
  final String id; // ID فريد لكل عنصر (ممكن productId)
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product.toJson(),
    'quantity': quantity,
  };
}
