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


///////////////////////////
final class AddProductLoading extends EcommerceState {
  const AddProductLoading();

  @override
  List<Object?> get props => [];
}

final class AddProductFailureState extends EcommerceState {
  final String errMessage;

  @override
  List<Object?> get props => [errMessage];

  const AddProductFailureState({required this.errMessage});
}

final class AddProductSuccess extends EcommerceState {
  final CartEntity cart;

  @override
  List<Object?> get props => [cart];

  const  AddProductSuccess({required this.cart});
}
//////////////////////////////////
final class DeleteProductLoadingState extends EcommerceState {
  const DeleteProductLoadingState();

  @override
  List<Object?> get props =>[];
}

final class DeleteFailureState extends EcommerceState {
  final String errMessage;

  const DeleteFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class DeleteSuccessState extends EcommerceState {
  final CartEntity cartEntity;

  const DeleteSuccessState({required this.cartEntity});

  @override
  List<Object?> get props => [cartEntity];
}

class EcommerceImagesUpdated extends EcommerceState {
  final List<ImageEntity> images;
  EcommerceImagesUpdated(this.images);

  @override
  List<Object?> get props => [images];
}

