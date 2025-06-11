part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

final class OrdersFetchEvent extends OrdersEvent {}

final class OrdersAddEvent extends OrdersEvent {
  final Address address;
  final List<Restaurant> restaurants;
  final List<RestaurantMenuItem> items;
  OrdersAddEvent(this.address, this.restaurants, this.items);
}
