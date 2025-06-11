part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {
  CartInitial();
}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final List<CartItem> cartItems;
  final Address? address;

  CartSuccess(this.cartItems, this.address);
}

final class CartFailure extends CartState {
  final String message;

  CartFailure(this.message);
}

final class CartCheckoutLoading extends CartState {
  final Address address;
  final List<CartItem> cartItems;
  CartCheckoutLoading(this.cartItems, this.address);
}

final class CartCheckoutFailure extends CartState {
  final String message;
  final Address? address;
  final List<CartItem> cartItems;

  CartCheckoutFailure(this.cartItems, this.address, this.message);
}

final class CartCheckoutSuccess extends CartState {}
