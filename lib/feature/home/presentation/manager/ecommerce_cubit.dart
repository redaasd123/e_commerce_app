import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/ecommerce_use_case.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/cart_entity.dart';

part 'ecommerce_state.dart';

class EcommerceCubit extends Cubit<EcommerceState> {
  final ECommerceUseCase eCommerceUseCase;

  //////////PageNation//////////////////
  final List<CartEntity> allProduct = [];
  bool isLoading = false;
  int currentPage = 0;
  bool hasReachedEnd = false;

  ///////////////Search////////////////
  List<CartEntity> searchResults = [];
  bool isSearching = false;

  EcommerceCubit(this.eCommerceUseCase) : super(EcommerceInitial());

  Future<void> fetchProduct() async {
    if (isLoading || hasReachedEnd) return;
    if (currentPage == 0) {
      emit(EcommerceLoadingState());
    }

    isLoading = true;

    final result = await eCommerceUseCase.call(currentPage);

    result.fold(
      (failure) {
        isLoading = false;
        emit(EcommerceFailureState(errMessage: failure.errMessage));
      },
      (product) {
        if (product.isEmpty) {
          hasReachedEnd = true;
        } else {
          currentPage++;
          allProduct.addAll(product);
        }

        isLoading = false;

        emit(
          EcommerceSuccessState(
            cart: List.from(allProduct),
            hasReachedEnd: hasReachedEnd,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  void refresh() {
    allProduct.clear();
    currentPage = 0;
    hasReachedEnd = false;
    fetchProduct();
  }

  int? _scrollToCartIndex;

  int? get scrollToCartIndex => _scrollToCartIndex;

  int? _openedCartId;

  int? get openedCartId => _openedCartId;

  void searchProduct(String query) {
    if (query.isEmpty) {
      _scrollToCartIndex = null;
      _openedCartId = null;

      emit(
        EcommerceSuccessState(
          cart: allProduct,
          hasReachedEnd: false,
          isLoadingMore: false,
        ),
      );
    } else {
      final filtered = allProduct.where((cart) {
        return cart.products.any(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()),
        );
      }).toList();

      _scrollToCartIndex = filtered.isNotEmpty
          ? allProduct.indexOf(filtered.first)
          : null;

      _openedCartId = filtered.isNotEmpty ? filtered.first.id : null;

      emit(
        EcommerceSuccessState(
          cart: filtered,
          hasReachedEnd: true,
          isLoadingMore: false,
          isSearching: true,
          searchResults: filtered,
        ),
      );
    }
  }
}
