part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductFailureState extends AddProductState {
  final String errMessage;

  AddProductFailureState({required this.errMessage});
}

final class AddProductSuccess extends AddProductState {
  final CartEntity cart;
  AddProductSuccess({required this.cart});
}
