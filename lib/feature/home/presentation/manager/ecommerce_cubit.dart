import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_local_data_source/ecommerce_local_data_source.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/delete_produc_use_case.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/ecommerce_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/cart_entity/cart_entity.dart';
import '../../domain/entity/image_entity.dart';
import '../../domain/use_case/add_product_use_case.dart';
import '../views/widget/param/add_product_param.dart';
import '../views/widget/param/delete_product_param.dart';

part 'ecommerce_state.dart';

class EcommerceCubit extends Cubit<EcommerceState> {
  final ECommerceUseCase eCommerceUseCase;
  final EcommerceLocalDataSource localDataSource;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  final List<CartEntity> allProduct = [];
  bool isLoading = false;
  int currentPage = 0;
  bool hasReachedEnd = false;

  List<CartEntity> searchResults = [];
  bool isSearching = false;

  final List<ImageEntity> _images = [];
  List<ImageEntity> get images => List.unmodifiable(_images);

  EcommerceCubit(
    this.eCommerceUseCase,
    this.localDataSource,
    this.addProductUseCase,
    this.deleteProductUseCase,
  ) : super(EcommerceInitial());

  Future<void> fetchProduct() async {
    final cachedData = await localDataSource.fetchProduct();

    if (currentPage == 0 && cachedData != null && cachedData.isNotEmpty) {
      allProduct.addAll(cachedData);
      emit(
        EcommerceSuccessState(
          cart: List.from(allProduct),
          hasReachedEnd: false,
          isLoadingMore: false,
        ),
      );
    }

    if (isLoading || hasReachedEnd) return;
    if (currentPage == 0 && allProduct.isEmpty) {
      emit(EcommerceLoadingState());
    }

    isLoading = true;

    final result = await eCommerceUseCase.call(currentPage);

    result.fold(
      (failure) {
        isLoading = false;

        if (allProduct.isNotEmpty) {
          emit(
            EcommerceSuccessState(
              cart: List.from(allProduct),
              hasReachedEnd: true,
              isLoadingMore: false,
            ),
          );
        } else {
          emit(EcommerceFailureState(errMessage: failure.errMessage));
        }
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
  Future<void> addProduct(AddProductParam param) async {
    emit(AddProductLoading());

    var result = await addProductUseCase.call(param);
    result.fold(
          (failure) => emit(AddProductFailureState(errMessage: failure.toString())),
          (cart) {
        allProduct.add(cart);
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

  Future<void> deleteProduct(DeleteProductParam param) async {
    emit(DeleteProductLoadingState());

    var result = await deleteProductUseCase.call(param);
    result.fold(
          (failure) => emit(DeleteFailureState(errMessage: failure.errMessage)),
          (cartEntity) {
        allProduct.removeWhere((cart) => cart.id == cartEntity.id);
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





  void addImage(String url, num price) {
    _images.add(ImageEntity(imageUrl: url, price: price));
    emit(EcommerceImagesUpdated(List.from(_images))); }

  void removeImageByUrl(String url) {
    _images.removeWhere((img) => img.imageUrl == url);
    emit(EcommerceImagesUpdated(List.from(_images)));
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

      if (state is EcommerceSuccessState) {
        emit(
          (state as EcommerceSuccessState).copyWith(
            cart: allProduct,
            hasReachedEnd: false,
            isLoadingMore: false,
            isSearching: false,
            searchResults: [],
          ),
        );
      }
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

      if (state is EcommerceSuccessState) {
        emit(
          (state as EcommerceSuccessState).copyWith(
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
}
