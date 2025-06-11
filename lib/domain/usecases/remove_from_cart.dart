import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/repository/cart_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class RemoveFromCart implements UseCase<void, RemoveFromCartParams> {
  final CartRepository _repository;

  RemoveFromCart(this._repository);

  @override
  Future<Either<Failure, void>> call(RemoveFromCartParams params) {
    return _repository.removeFromCart(params.userId, params.itemId);
  }
}

class RemoveFromCartParams {
  final String userId;
  final String itemId;

  RemoveFromCartParams(this.userId, this.itemId);
}
