import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class AddAddress implements UseCase<void, AddAddressParams> {
  final UserRepository _repository;

  AddAddress(this._repository);

  @override
  Future<Either<Failure, void>> call(AddAddressParams params) {
    return _repository.addAddress(params.userId, params.address);
  }
}

class AddAddressParams {
  final String userId;
  final Address address;

  const AddAddressParams({required this.userId, required this.address});

  @override
  List<Object?> get props => [userId, address];
}
