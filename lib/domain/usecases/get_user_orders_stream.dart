import 'package:dartz/dartz.dart' hide Order;
import 'package:mini_zomato_user/domain/entities/order.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class GetUserOrdersStream
    implements UseCase<Stream<List<Order>>, GetUserOrdersStreamParams> {
  final UserRepository _repository;

  GetUserOrdersStream(this._repository);

  @override
  Future<Either<Failure, Stream<List<Order>>>> call(
    GetUserOrdersStreamParams params,
  ) {
    return _repository.getUserOrders(params.userId);
  }
}

class GetUserOrdersStreamParams {
  final String userId;

  GetUserOrdersStreamParams(this.userId);
}
