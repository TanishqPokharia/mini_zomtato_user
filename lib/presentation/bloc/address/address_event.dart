part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

final class AddressFetchEvent extends AddressEvent {}

final class AddressAddEvent extends AddressEvent {
  final String label;
  final String state;
  final String city;
  final String addressLine1;
  final String addressLine2;
  final int pincode;
  AddressAddEvent(
    this.label,
    this.state,
    this.city,
    this.addressLine1,
    this.addressLine2,
    this.pincode,
  );
}
