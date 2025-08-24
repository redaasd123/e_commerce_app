part of 'ecommerce_cubit.dart';

@immutable
sealed class EcommerceState extends Equatable {
  const EcommerceState();

  @override
  List<Object?> get props => [];
}

/// ✅ الحالة الأولية
final class EcommerceInitial extends EcommerceState {}

/// ✅ تحميل أول مرة (Splash or full screen loader)
final class EcommerceLoadingState extends EcommerceState {}

/// ✅ تحميل بيانات بنجاح
final class EcommerceSuccessState extends EcommerceState {
  final List<CartEntity> cart;
  final bool hasReachedEnd;
  final bool isLoadingMore;
  final bool isSearching;
  final List<CartEntity> searchResults;

  const EcommerceSuccessState({
    required this.cart,
    required this.hasReachedEnd,
    this.isLoadingMore = false,
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

/// ✅ أوفلاين (من الكاش)
final class EcommerceOfflineState extends EcommerceState {
  final List<CartEntity> cart;
  const EcommerceOfflineState({required this.cart});

  @override
  List<Object?> get props => [cart];
}

/// ✅ فشل في تحميل البيانات
final class EcommerceFailureState extends EcommerceState {
  final String errMessage;
  final List<CartEntity> oldData;

  const EcommerceFailureState({
    required this.errMessage,
    this.oldData = const [],
  });

  @override
  List<Object?> get props => [errMessage, oldData];
}

////////////////////////////////////////
/// 🛒 إضافة منتج
final class AddProductLoading extends EcommerceState {}

final class AddProductFailureState extends EcommerceState {
  final String errMessage;
  const AddProductFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class AddProductSuccess extends EcommerceState {
  final CartEntity cart;
  const AddProductSuccess({required this.cart});

  @override
  List<Object?> get props => [cart];
}

////////////////////////////////////////
/// ❌ حذف منتج
final class DeleteProductLoadingState extends EcommerceState {}

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

////////////////////////////////////////
/// 🖼️ الصور
class EcommerceImagesUpdated extends EcommerceState {
  final List<ImageEntity> images;
  const EcommerceImagesUpdated(this.images);

  @override
  List<Object?> get props => [images];
}
