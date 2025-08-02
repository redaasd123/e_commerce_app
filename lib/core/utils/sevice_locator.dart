import 'package:dio/dio.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_remote_data_source.dart';
import 'package:e_commerce_app/feature/home/data/repos/ecommerce_impl.dart';
import 'package:e_commerce_app/feature/home/domain/repo/ecommerce_repo.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/add_product_use_case.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/delete_produc_use_case.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/ecommerce_use_case.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/add_product/add_product_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/delete_product/delete_cubit.dart';
import 'package:e_commerce_app/feature/home/presentation/manager/ecommerce_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../feature/home/presentation/manager/image_product_cubit/image_cubit.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  ////////////////////Dio
  final dio = Dio();
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<Api>(() => Api(dio: getIt<Dio>()));

  getIt.registerLazySingleton<ECommerceRepo>(
    () => ECommerceRepoImpl(eCommerceDataSource: getIt.get()),
  );
  getIt.registerLazySingleton<ECommerceDataSource>(
    () => ECommerceDataSourceImpl(),
  );
  getIt.registerFactory<EcommerceCubit>(
    () => EcommerceCubit(getIt<ECommerceUseCase>()),
  );
  getIt.registerLazySingleton<ECommerceUseCase>(
    () => ECommerceUseCase(eCommerceRepo: getIt.get()),
  );



  getIt.registerLazySingleton<AddProductCubit>(
    () => AddProductCubit(getIt.get()),
  );
  getIt.registerLazySingleton<AddProductUseCase>(
    () => AddProductUseCase(eCommerceRepo: getIt.get()),

  );

  getIt.registerLazySingleton<DeleteProductCubit>(
        () => DeleteProductCubit(getIt.get()),
  );
  getIt.registerLazySingleton<DeleteProductUseCase>(
        () => DeleteProductUseCase(eCommerceRepo: getIt.get()),

  );
  getIt.registerFactory<ImageProductCubit>(()=>ImageProductCubit());
}
