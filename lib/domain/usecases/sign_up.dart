import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/user.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class SignUp implements UseCase<User, SignUpParams> {
  final UserRepository _repository;

  SignUp(this._repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return _repository.signUp(params.name, params.email, params.password);
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
