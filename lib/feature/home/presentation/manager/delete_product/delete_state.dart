part of 'delete_cubit.dart';

@immutable
sealed class DeleteState {}

final class DeleteLoadingState extends DeleteState {}
final class DeleteFailureState extends DeleteState {
  final String errMessage;

  DeleteFailureState({required this.errMessage});
}
final class DeleteSuccessState extends DeleteState {
  final CartEntity cartEntity;

  DeleteSuccessState({required this.cartEntity});
}
final class DeleteInitial extends DeleteState {}
