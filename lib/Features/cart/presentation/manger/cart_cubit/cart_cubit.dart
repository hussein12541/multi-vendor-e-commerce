import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/repos/cart_repo.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:multi_vendor_e_commerce_app/generated/l10n.dart';

import '../../../../../core/utils/functions/is_arabic.dart';
import '../../../../../core/utils/functions/show_message.dart';
import '../../../data/models/cart_model/cart_model.dart';
import '../../../../../core/models/product_model.dart';
import '../../../data/models/cart_item_model/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo;
  CartCubit(this.repo) : super(CartInitial());

  CartModel cart = CartModel(items: []);

  void addItem(ProductModel product, BuildContext context) {
    cart.addItem(product);
    emit(CartUpdated(cart));
    ShowMessage.showToast(S.of(context).addedToCartSuccessfully, backgroundColor: Colors.green);
  }

  void increaseQuantity(String productId, BuildContext context) {
    final item = cart.items.firstWhere(
          (element) => element.product.id == productId,
      orElse: () => throw Exception('Product not found'),
    );

    if (item.quantity < item.product.quantity) {
      item.quantity += 1;
      emit(CartUpdated(cart));
      ShowMessage.showToast(S.of(context).quantityIncreased, backgroundColor: Colors.green);
    } else {
      ShowMessage.showToast(S.of(context).maxQuantityReached);
    }
  }

  void decreaseQuantity(String productId, BuildContext context) {
    final item = cart.items.firstWhere(
          (element) => element.product.id == productId,
      orElse: () => throw Exception('Product not found'),
    );
    if (item.quantity > 1) {
      item.quantity -= 1;
      ShowMessage.showToast(S.of(context).quantityDecreased, backgroundColor: Colors.orange);
    } else {
      removeItem(productId, context);
    }
    emit(CartUpdated(cart));
  }

  Future<String>addProductToCart( {required BuildContext context,required CartModel cart,required String name,required String phone,required String address,required bool isPaid,required String addressUrl,required double price,})async{
    emit(AddItemsToCartLoading());
    final result = await repo.addProductToCart(cart: cart,name: name,phone: phone,address: address,isPaid: isPaid,addressUrl: addressUrl,price: price);

    await context.read<ProductCubit>().getProducts();
    return result.fold(
      (failure) {
        log("addProductToCart error"+failure.errMessage);
        emit(AddItemsToCartError());
    
        return failure.errMessage;
      },
      (success) {
        emit(CartUpdated(cart));
        
        return success;
      },
    );
  
  }
  
Future<bool> checkProductsAvilable(CartModel cart,BuildContext context) async {
  emit(CheckCartAvilableLoading());
  final result = await repo.checkProductsAvilable(context,cart);
  return result.fold(
    (failure) {
      emit(CheckCartAvilableError());
      ShowMessage.showToast(failure.errMessage);
      return false;
    },
    (isAvailable)  {
      emit(CheckCartAvilableSuccess());
      return isAvailable;},
  );
}

// Add this in CartCubit class
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  void removeItem(String productId, BuildContext context) {
    final index = cart.items.indexWhere((item) => item.id == productId);

    if (index == -1) return;

    final removedItem = cart.items[index];

    // ابعت للـ AnimatedList إنه يشيل العنصر
    listKey.currentState?.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildRemovedItem(removedItem, context),
      ),
      duration: const Duration(milliseconds: 300),
    );

    // 💤 خلي الحذف يحصل بعد شوية (بعد الإنيميشن)
    Future.delayed(const Duration(milliseconds: 300), () {
      cart.items.removeAt(index);
      emit(CartUpdated(cart));
    });

    ShowMessage.showToast(S.of(context).itemRemoved, backgroundColor: Colors.red);
  }

  Widget _buildRemovedItem(CartItemModel item, BuildContext context) {
    final locale = LanguageHelper.isArabic()
        ? item.product.arabicName
        : item.product.englishName;

    return ListTile(
      title: Text(locale),
      subtitle: Text('${item.quantity} x ${item.product.price.toStringAsFixed(2)} ${S.of(context).currency}'),
      leading: Image.network(
        item.product.imageUrl ?? '',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      ),
    );
  }




  void clearCart(BuildContext context) {
    cart.clear();
    emit(CartUpdated(cart));
    // ShowMessage.showToast(S.of(context).cartCleared, backgroundColor: Colors.red);
  }

}
