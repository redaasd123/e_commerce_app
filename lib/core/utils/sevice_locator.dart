import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_local_data_source/ecommerce_local_data_source.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_remote_data_source/ecommerce_remote_data_source.dart';
import 'package:e_commerce_app/feature/home/data/repos/ecommerce_impl.dart';
import 'package:e_commerce_app/feature/home/domain/repo/ecommerce_repo.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/add_product_use_case.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/delete_produc_use_case.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/ecommerce_use_case.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../feature/home/presentation/manager/image_product_cubit/image_cubit.dart';
import 'api_service.dart';

final getIt = GetIt.instance;


void setUpServiceLocator() {
  // API
  final dio = Dio();
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<Api>(() => Api(dio: getIt()));

  // Data Sources

  getIt.registerLazySingleton<ECommerceDataSource>(
        () => ECommerceDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<ECommerceRepo>(
        () => ECommerceRepoImpl(
      ecommerceLocalDataSource: getIt(),
      eCommerceDataSource: getIt(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton<ECommerceUseCase>(
        () => ECommerceUseCase(eCommerceRepo: getIt()),
  );
  getIt.registerLazySingleton<AddProductUseCase>(
        () => AddProductUseCase(eCommerceRepo: getIt()),
  );
  getIt.registerLazySingleton<DeleteProductUseCase>(
        () => DeleteProductUseCase(eCommerceRepo: getIt()),
  );getIt.registerLazySingleton<EcommerceLocalDataSource>(()=>EcommerceLocalDataSourceImpl());  // Cubits
  getIt.registerFactory<EcommerceCubit>(
        () => EcommerceCubit(getIt(), getIt.get(),getIt.get(),getIt.get()),
  );

  getIt.registerFactory<ImageProductCubit>(
        () => ImageProductCubit(),
  );

  // Network Check
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker(),
  );
}
