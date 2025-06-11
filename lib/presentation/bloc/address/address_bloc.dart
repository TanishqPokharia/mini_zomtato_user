import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_zomato_user/data/models/address/address.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/usecases/add_address.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_addresses.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_profile.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:uuid/uuid.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  List<Address> _addresses = [];

  final GetUserProfile _getUserProfile;
  final GetUserAddresses _getUserAddresses;
  final AddAddress _addAddress;

  AddressBloc(this._getUserProfile, this._getUserAddresses, this._addAddress)
    : super(AddressInitial()) {
    on<AddressFetchEvent>((event, emit) async {
      emit(AddressLoading());
      final userDetails = await _getUserProfile(NoParams());
      await userDetails.fold(
        (failure) {
          emit(AddressFailure(failure.message));
        },
        (details) async {
          final userId = details.id;
          final addressesResult = await _getUserAddresses(
            GetUserAddressesParams(userId: userId),
          );
          addressesResult.fold(
            (failure) {
              emit(AddressFailure(failure.message));
            },
            (addressesList) {
              _addresses = addressesList;
              emit(
                AddressSuccess(
                  _addresses,
                  message: 'Addresses fetched successfully',
                ),
              );
            },
          );
        },
      );
    });

    on<AddressAddEvent>((event, emit) async {
      emit(AddressLoading());

      final userDetails = await _getUserProfile(NoParams());
      await userDetails.fold(
        (failure) {
          emit(AddressFailure(failure.message));
        },
        (details) async {
          final userId = details.id;
          final address = AddressModel(
            id: Uuid().v4(),
            label: event.label,
            state: event.state,
            city: event.city,
            addressLine1: event.addressLine1,
            addressLine2: event.addressLine2,
            pincode: event.pincode,
          );
          final result = await _addAddress(
            AddAddressParams(userId: userId, address: address),
          );
          result.fold(
            (failure) {
              emit(AddressFailure(failure.message));
            },
            (_) {
              _addresses.add(address);
              emit(
                AddressSuccess(
                  _addresses,
                  message: 'Address added successfully',
                ),
              );
            },
          );
        },
      );
    });
  }
}
