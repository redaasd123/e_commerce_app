part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState extends Equatable {
  const AddProductState();
}

final class AddProductInitial extends AddProductState {
  const AddProductInitial();

  @override
  List<Object?> get props => [];
}

final class AddProductLoading extends AddProductState {
  const AddProductLoading();

  @override
  List<Object?> get props => [];
}

final class AddProductFailureState extends AddProductState {
  final String errMessage;

  @override
  List<Object?> get props => [errMessage];

  const AddProductFailureState({required this.errMessage});
}

final class AddProductSuccess extends AddProductState {
  final CartEntity cart;

  @override
  List<Object?> get props => [cart];

 const  AddProductSuccess({required this.cart});
}
