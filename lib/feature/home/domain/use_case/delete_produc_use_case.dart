import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/core/param/delete_product_param.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/domain/repo/ecommerce_repo.dart';

import '../../../../core/use_case/use_case.dart';

class DeleteProductUseCase extends UseCase<CartEntity, DeleteProductParam> {
  final ECommerceRepo eCommerceRepo;

  DeleteProductUseCase({required this.eCommerceRepo});

  @override
  Future<Either<Failure, CartEntity>> call(DeleteProductParam param) async {
    return await eCommerceRepo.deleteProduct(param: param);
  }
}
