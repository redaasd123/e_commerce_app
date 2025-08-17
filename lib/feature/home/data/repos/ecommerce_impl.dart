import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/core/save_data/save_data.dart';
import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_local_data_source/ecommerce_local_data_source.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_remote_data_source/ecommerce_remote_data_source.dart';
import 'package:e_commerce_app/feature/home/domain/repo/ecommerce_repo.dart';
import 'package:hive/hive.dart';

import '../../domain/entity/cart_entity/cart_entity.dart';
import '../../domain/entity/product_entity/product_entity.dart';
import '../../presentation/views/widget/param/add_product_param.dart';
import '../../presentation/views/widget/param/delete_product_param.dart';
import '../data_source/ecommerce_local_data_source/cart_cash_model.dart';

class ECommerceRepoImpl extends ECommerceRepo {
  final ECommerceDataSource eCommerceDataSource;
  final EcommerceLocalDataSource ecommerceLocalDataSource;

  ECommerceRepoImpl({
    required this.ecommerceLocalDataSource,
    required this.eCommerceDataSource,
  });


  @override
  Future<Either<Failure, List<CartEntity>>> fetchProduct({
    required int limit,
    required int skip,
  }) async {
    final isConnected = await _isConnectedToInternet();

    try {
      if (isConnected) {
        // جلب البيانات من السيرفر
        final result = await eCommerceDataSource.fetchProduct(
          limit: limit,
          skip: skip,
        );

        // تحويل النتائج للكاش وتخزينها في Hive
        final cacheList =
        result.map((cart) => CartCacheModel.fromEntity(cart)).toList();
        await ecommerceLocalDataSource.saveCarts(cacheList);

        return Right(result);
      } else {
        // لو مفيش نت، جلب البيانات من الكاش
        final cachedData = await ecommerceLocalDataSource.fetchProduct();
        if (cachedData.isNotEmpty) {
          return Right(cachedData);
        } else {
          return Left(ServerFailure(errMessage: "No internet and no cached data"));
        }
      }
    } on DioException catch (e) {
      // لو حصل خطأ في API
      final cachedData = await ecommerceLocalDataSource.fetchProduct();
      if (cachedData.isNotEmpty) return Right(cachedData);

      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }



  Future<bool> _isConnectedToInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
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