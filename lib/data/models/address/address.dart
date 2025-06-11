import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
abstract class AddressModel with _$AddressModel implements Address {
  const factory AddressModel({
    required String id,
    required String label,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String state,
    required int pincode,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  factory AddressModel.fromEntity(Address address) {
    return AddressModel(
      id: address.id,
      label: address.label,
      addressLine1: address.addressLine1,
      addressLine2: address.addressLine2,
      city: address.city,
      state: address.state,
      pincode: address.pincode,
    );
  }
}
