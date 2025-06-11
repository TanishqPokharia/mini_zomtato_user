import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class DeleteAddress implements UseCase<void, DeleteAddressParams> {
  final UserRepository _repository;

  DeleteAddress(this._repository);

  @override
  Future<Either<Failure, void>> call(DeleteAddressParams params) {
    return _repository.deleteAddress(params.userId, params.addressId);
  }
}

class DeleteAddressParams {
  final String userId;
  final String addressId;

  const DeleteAddressParams({required this.userId, required this.addressId});

  @override
  List<Object?> get props => [userId, addressId];
}
