part of 'offer_cubit.dart';

@immutable
sealed class OfferState {}

final class OfferInitial extends OfferState {}

final class GetOffersSuccess extends OfferState {
  final List<OfferModel>offers;
  GetOffersSuccess(this.offers);
}
final class GetOffersLoading extends OfferState {}
final class GetOffersError extends OfferState {
  final String errorMessage;
  GetOffersError(this.errorMessage);
}
