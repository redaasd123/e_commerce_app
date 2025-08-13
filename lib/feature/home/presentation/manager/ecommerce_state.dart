part of 'ecommerce_cubit.dart';
@immutable
sealed class EcommerceState extends Equatable {
  const EcommerceState();
}

final class EcommerceInitial extends EcommerceState {
  @override
  List<Object?> get props => [];
}

final class EcommerceLoadingState extends EcommerceState {
  @override
  List<Object?> get props => [];
}

final class EcommerceSuccessState extends EcommerceState {
  final List<CartEntity> cart;
  final bool hasReachedEnd;
  final bool? isLoadingMore;
  final bool isSearching;
  final List<CartEntity> searchResults;

  const EcommerceSuccessState({
    required this.cart,
    required this.hasReachedEnd,
    required this.isLoadingMore,
    this.isSearching = false,
    this.searchResults = const [],
  });

  EcommerceSuccessState copyWith({
    List<CartEntity>? cart,
    bool? hasReachedEnd,
    bool? isLoadingMore,
    bool? isSearching,
    List<CartEntity>? searchResults,
  }) {
    return EcommerceSuccessState(
      cart: cart ?? this.cart,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSearching: isSearching ?? this.isSearching,
      searchResults: searchResults ?? this.searchResults,
    );
  }


  @override
  List<Object?> get props =>
      [cart, hasReachedEnd, isLoadingMore, isSearching, searchResults];
}

final class cashIsNotEmptyState extends EcommerceState{

  List<Object?> get props => throw UnimplementedError();

}

final class EcommerceFailureState extends EcommerceState {
  final String errMessage;

  const EcommerceFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

//final class EcommerceSuccessState extends EcommerceState {
//   final List<CartEntity> cart;
//   final bool hasReachedEnd;
//   final bool? isLoadingMore;
//   final bool isSearching;
//   final List<CartEntity> searchResults;
//
//   const EcommerceSuccessState({
//     required this.cart,
//     required this.hasReachedEnd,
//     required this.isLoadingMore,
//     this.isSearching = false,
//     this.searchResults = const [],
//   });
//
//   EcommerceSuccessState copyWith({
//     List<CartEntity>? cart,
//     bool? hasReachedEnd,
//     bool? isLoadingMore,
//     bool? isSearching,
//     List<CartEntity>? searchResults,
//   }) {
//     return EcommerceSuccessState(
//       cart: cart ?? this.cart,
//       hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
//       isLoadingMore: isLoadingMore ?? this.isLoadingMore,
//       isSearching: isSearching ?? this.isSearching,
//       searchResults: searchResults ?? this.searchResults,
//     );
//   }