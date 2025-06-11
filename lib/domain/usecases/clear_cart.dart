import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/repository/cart_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class ClearCart implements UseCase<void, ClearCartParams> {
  final CartRepository _repository;

  ClearCart(this._repository);

  @override
  Future<Either<Failure, void>> call(ClearCartParams params) {
    return _repository.clearCart(params.userId);
  }
}

class ClearCartParams {
  final String userId;

  const ClearCartParams(this.userId);
}
