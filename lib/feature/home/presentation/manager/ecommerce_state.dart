part of 'ecommerce_cubit.dart';

@immutable
sealed class EcommerceState {}

final class EcommerceInitial extends EcommerceState {}

final class EcommerceLoadingState extends EcommerceState {}

final class EcommerceSuccessState extends EcommerceState {
  final List<CartEntity> cart;
  final bool hasReachedEnd;
  final bool? isLoadingMore;
  final bool isSearching;
  final List<CartEntity> searchResults;

  EcommerceSuccessState({
    required this.cart,
    required this.hasReachedEnd,
    required this.isLoadingMore,
    this.isSearching = false,
    this.searchResults = const [],
  });
}

final class EcommerceFailureState extends EcommerceState {
  final String errMessage;

  EcommerceFailureState({required this.errMessage});
}
