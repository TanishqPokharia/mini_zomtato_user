part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressSuccess extends AddressState {
  final List<Address> addresses;
  final String? message;

  AddressSuccess(this.addresses, {this.message});
}

final class AddressFailure extends AddressState {
  final String message;

  AddressFailure(this.message);
}
