import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
