import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/core/param/add_product_param.dart';
import 'package:e_commerce_app/core/param/delete_product_param.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_remote_data_source.dart';
import 'package:e_commerce_app/feature/home/domain/repo/ecommerce_repo.dart';

import '../../domain/entity/cart_entity.dart';

class ECommerceRepoImpl extends ECommerceRepo {
  final ECommerceDataSource eCommerceDataSource;

  ECommerceRepoImpl({required this.eCommerceDataSource});

  @override
  Future<Either<Failure, List<CartEntity>>> fetchProduct({
    required int limit,
    required int skip,
  }) async {
    try {
      var result = await eCommerceDataSource.fetchProduct(
        limit: limit,
        skip: skip,
      );
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addProduct({
    required AddProductParam param,
  }) async {
    try {
      var result = await eCommerceDataSource.addProduct(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, CartEntity>> deleteProduct({
    required DeleteProductParam param,
  }) async {
    try {
      var result = await eCommerceDataSource.deleteProduct(param);
      return right(result);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
