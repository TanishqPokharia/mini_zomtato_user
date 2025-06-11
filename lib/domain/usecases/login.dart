import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/user.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class Login implements UseCase<User, LoginParams> {
  final UserRepository _repository;

  Login(this._repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return _repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
