part of 'userorders_bloc.dart';

sealed class UserordersState extends Equatable {
  const UserordersState();

  @override
  List<Object> get props => [];
}

final class UserordersInitial extends UserordersState {}

final class CompletedOrdersState extends UserordersState {
  final List<ProductModel> products;
  final List<OrderModel> orders;
  const CompletedOrdersState({required this.orders, required this.products});
}

final class PendingOrdersState extends UserordersState {
  final List<ProductModel> products;
  final List<OrderModel> orders;
  const PendingOrdersState({required this.orders, required this.products});
}

final class LoadingState extends UserordersState {}
