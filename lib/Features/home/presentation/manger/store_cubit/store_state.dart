part of 'store_cubit.dart';

@immutable
sealed class StoreState {}

final class StoreInitial extends StoreState {}

final class GetStoresLoading extends StoreState {}
final class GetStoresSuccess extends StoreState {
  final List<StoreModel>stores;
  GetStoresSuccess(this.stores);
}
final class GetStoresError extends StoreState {
  final String errorMessage;
  GetStoresError(this.errorMessage);
}
