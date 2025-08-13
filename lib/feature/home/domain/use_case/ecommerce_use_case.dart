import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/feature/home/domain/repo/ecommerce_repo.dart';

import '../../../../core/use_case/use_case.dart';
import '../entity/cart_entity/cart_entity.dart';

class ECommerceUseCase extends UseCase<List<CartEntity>, int> {
  final ECommerceRepo eCommerceRepo;

  ECommerceUseCase({required this.eCommerceRepo});

  @override
  Future<Either<Failure, List<CartEntity>>> call(int pageNumber) async {
    const int limit = 10;
    final int skip = pageNumber * limit;
    return eCommerceRepo.fetchProduct(limit: limit, skip: skip);
  }
}
