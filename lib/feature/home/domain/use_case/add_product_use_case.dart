import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';

import '../../../../core/use_case/use_case.dart';
import '../../presentation/views/widget/param/add_product_param.dart';
import '../repo/ecommerce_repo.dart';

class AddProductUseCase extends UseCase<CartEntity,AddProductParam>{
  final ECommerceRepo eCommerceRepo;

  AddProductUseCase({required this.eCommerceRepo});

  @override
  Future<Either<Failure, CartEntity>> call(AddProductParam param) async{
    return await eCommerceRepo.addProduct(param: param);
  }



}