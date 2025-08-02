import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/core/param/add_product_param.dart';
import 'package:e_commerce_app/core/param/delete_product_param.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entity/product_entity.dart';

abstract class ECommerceRepo {
  Future<Either<Failure, List<CartEntity>>> fetchProduct({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, CartEntity>> addProduct({
    required AddProductParam param,
  });

  Future<Either<Failure, CartEntity>> deleteProduct({
    required DeleteProductParam param,
  });
}
