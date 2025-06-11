part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersSuccess extends OrdersState {
  final List<Order> orders;
  final String? message;

  OrdersSuccess(this.orders, {this.message});
}

final class OrdersFailure extends OrdersState {
  final String message;

  OrdersFailure(this.message);
}
