part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class CartFetchEvent extends CartEvent {}

final class CartAddEvent extends CartEvent {
  final Restaurant restaurant;
  final RestaurantMenuItem restaurantMenuItem;

  CartAddEvent(this.restaurant, this.restaurantMenuItem);
}

final class CartRemoveEvent extends CartEvent {
  final String cartItemId;
  final String menuItemId;

  CartRemoveEvent(this.cartItemId, this.menuItemId);
}

final class CartAddressSetEvent extends CartEvent {
  final Address address;

  CartAddressSetEvent(this.address);
}

final class CartClearEvent extends CartEvent {
  CartClearEvent();
}

final class CartCheckoutEvent extends CartEvent {}
