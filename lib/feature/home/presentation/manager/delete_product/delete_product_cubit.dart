import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/delete_produc_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../views/widget/param/delete_product_param.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  final DeleteProductUseCase deleteProductUseCase;

  DeleteProductCubit(this.deleteProductUseCase) : super(DeleteInitial());

  Future<void> deleteProduct(DeleteProductParam param) async {
    var result = await deleteProductUseCase.call(param);
    result.fold(
      (failure) => emit(DeleteFailureState(errMessage: failure.errMessage)),
      (cartEntity) => emit(DeleteSuccessState(cartEntity: cartEntity)),
    );
  }
}
