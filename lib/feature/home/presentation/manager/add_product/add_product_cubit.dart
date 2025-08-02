import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/param/add_product_param.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/domain/use_case/add_product_use_case.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.addProductUseCase) : super(AddProductInitial());
  final AddProductUseCase addProductUseCase;

  Future<void> addProduct(AddProductParam param) async {
    var result = await addProductUseCase.call(param);
    result.fold(
      (failure) => emit(AddProductFailureState(errMessage: failure.toString())),
      (cart) => emit(AddProductSuccess(cart: cart)),
    );
  }
}
