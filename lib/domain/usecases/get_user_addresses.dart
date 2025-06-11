import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class GetUserAddresses
    implements UseCase<List<Address>, GetUserAddressesParams> {
  final UserRepository _repository;

  GetUserAddresses(this._repository);

  @override
  Future<Either<Failure, List<Address>>> call(GetUserAddressesParams params) {
    return _repository.getUserAddresses(params.userId);
  }
}

class GetUserAddressesParams {
  final String userId;

  const GetUserAddressesParams({required this.userId});
}
