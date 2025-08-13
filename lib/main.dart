import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/core/connectivity/check_internet_cubit.dart';
import 'package:e_commerce_app/core/utils/app_router.dart';
import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:e_commerce_app/core/utils/sevice_locator.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'feature/home/domain/entity/product_entity/product_entity.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(CartEntityAdapter());

  Hive.deleteBoxFromDisk(kCatBox);
  await Hive.openBox<CartEntity>(kCatBox);
  setUpServiceLocator();
  runApp(EcommerceApp());
}


class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckInternetCubit(
        getIt<Connectivity>(),
        getIt<InternetConnectionChecker>(),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
//import 'package:bloc/bloc.dart';
// import 'package:e_commerce_app/feature/home/domain/use_case/ecommerce_use_case.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// import '../../domain/entity/cart_entity/cart_entity.dart';
//
// part 'ecommerce_state.dart';
//
// class EcommerceCubit extends Cubit<EcommerceState> {
//   final ECommerceUseCase eCommerceUseCase;
//
//   final List<CartEntity> allProduct = [];
//   bool isLoading = false;
//   int currentPage = 0;
//   bool hasReachedEnd = false;
//
//   List<CartEntity> searchResults = [];
//   bool isSearching = false;
//
//   EcommerceCubit(this.eCommerceUseCase) : super(EcommerceInitial());
//
//   Future<void> fetchProduct() async {
//     if (isLoading || hasReachedEnd) return;
//     if (currentPage == 0) {
//       emit(EcommerceLoadingState());
//     }
//
//     isLoading = true;
//
//     final result = await eCommerceUseCase.call(currentPage);
//
//     result.fold(
//           (failure) {
//         isLoading = false;
//         emit(EcommerceFailureState(errMessage: failure.errMessage));
//       },
//           (product) {
//         if (product.isEmpty) {
//           hasReachedEnd = true;
//         } else {
//           currentPage++;
//           allProduct.addAll(product);
//         }
//
//         isLoading = false;
//
//         if (state is EcommerceSuccessState) {
//           emit((state as EcommerceSuccessState).copyWith(
//             cart: List.from(allProduct),
//             hasReachedEnd: hasReachedEnd,
//             isLoadingMore: false,
//           ));
//         } else {
//           emit(EcommerceSuccessState(
//             cart: List.from(allProduct),
//             hasReachedEnd: hasReachedEnd,
//             isLoadingMore: false,
//           ));
//         }
//       },
//     );
//   }
//
//   void refresh() {
//     allProduct.clear();
//     currentPage = 0;
//     hasReachedEnd = false;
//     fetchProduct();
//   }
//
//   int? _scrollToCartIndex;
//   int? get scrollToCartIndex => _scrollToCartIndex;
//
//   int? _openedCartId;
//   int? get openedCartId => _openedCartId;
//
//   void searchProduct(String query) {
//     if (query.isEmpty) {
//       _scrollToCartIndex = null;
//       _openedCartId = null;
//
//       if (state is EcommerceSuccessState) {
//         emit((state as EcommerceSuccessState).copyWith(
//           cart: allProduct,
//           hasReachedEnd: false,
//           isLoadingMore: false,
//           isSearching: false,
//           searchResults: [],
//         ));
//       }
//     } else {
//       final filtered = allProduct.where((cart) {
//         return cart.products.any(
//               (product) =>
//               product.title.toLowerCase().contains(query.toLowerCase()),
//         );
//       }).toList();
//
//       _scrollToCartIndex = filtered.isNotEmpty
//           ? allProduct.indexOf(filtered.first)
//           : null;
//
//       _openedCartId = filtered.isNotEmpty ? filtered.first.id : null;
//
//       if (state is EcommerceSuccessState) {
//         emit((state as EcommerceSuccessState).copyWith(
//           cart: filtered,
//           hasReachedEnd: true,
//           isLoadingMore: false,
//           isSearching: true,
//           searchResults: filtered,
//         ));
//       }
//     }
//   }
// }