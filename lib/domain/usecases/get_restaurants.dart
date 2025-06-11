import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/repository/restaurant_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class GetRestaurants implements UseCase<List<Restaurant>, NoParams> {
  final RestaurantRepository _repository;

  GetRestaurants(this._repository);

  @override
  Future<Either<Failure, List<Restaurant>>> call(NoParams params) {
    return _repository.getRestaurants();
  }
}
