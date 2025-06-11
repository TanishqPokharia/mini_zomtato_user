import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/domain/repository/cart_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class GetCartItems implements UseCase<List<CartItem>, GetCartItemsParams> {
  final CartRepository _repository;

  GetCartItems(this._repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(GetCartItemsParams params) {
    return _repository.getCartItems(params.userId);
  }
}

class GetCartItemsParams {
  final String userId;

  const GetCartItemsParams({required this.userId});
}
