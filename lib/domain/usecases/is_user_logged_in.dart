import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class IsUserLoggedIn implements UseCase<bool, NoParams> {
  final UserRepository _repository;

  IsUserLoggedIn(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.isUserLoggedIn();
  }
}
