import 'package:dartz/dartz.dart' hide Order;
import 'package:mini_zomato_user/domain/entities/order.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class AddToOrders implements UseCase<void, AddToOrdersParams> {
  final UserRepository _repository;
  AddToOrders(this._repository);
  @override
  Future<Either<Failure, void>> call(AddToOrdersParams params) {
    return _repository.addToOrders(params.userId, params.order);
  }
}

class AddToOrdersParams {
  final String userId;
  final Order order;

  AddToOrdersParams({required this.userId, required this.order});
}
