import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class Logout implements UseCase<void, NoParams> {
  final UserRepository _repository;

  Logout(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.logout();
  }
}
