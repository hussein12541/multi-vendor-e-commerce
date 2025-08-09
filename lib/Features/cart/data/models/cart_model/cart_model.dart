import '../../../../../core/models/product_model.dart';
import '../cart_item_model/cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;

  CartModel({required this.items});


  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  // جوه cart_model.dart
  void addItem(ProductModel product) {
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      items[index].quantity += 1;
    } else {
      items.add(CartItemModel(product: product, quantity: 1, id: product.id));
    }
  }
// Add in CartModel
  double get total => items.fold(0, (sum, item) => sum + (item.quantity * item.product.price));

  void removeItem(String productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  void clear() => items.clear();
}
