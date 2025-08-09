part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CheckCartAvilableLoading extends CartState {}
class CheckCartAvilableSuccess extends CartState {}
class CheckCartAvilableError extends CartState {}

class AddItemsToCartLoading extends CartState {}
class AddItemsToCartSuccess extends CartState {}
class AddItemsToCartError extends CartState {}

class CartUpdated extends CartState {
  final CartModel cart;

  CartUpdated(this.cart);
}
