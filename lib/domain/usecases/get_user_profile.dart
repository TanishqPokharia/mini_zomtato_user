import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/user.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class GetUserProfile implements UseCase<User, NoParams> {
  final UserRepository userRepository;

  GetUserProfile(this.userRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    final result = await userRepository.getUserProfile();
    return result;
  }
}
