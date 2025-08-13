part of 'delete_product_cubit.dart';

@immutable
sealed class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object?> get props => [];
}

final class DeleteLoadingState extends DeleteProductState {
  const DeleteLoadingState();
}

final class DeleteFailureState extends DeleteProductState {
  final String errMessage;

  const DeleteFailureState({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

final class DeleteSuccessState extends DeleteProductState {
  final CartEntity cartEntity;

  const DeleteSuccessState({required this.cartEntity});

  @override
  List<Object?> get props => [cartEntity];
}

final class DeleteInitial extends DeleteProductState {
  const DeleteInitial();
}
