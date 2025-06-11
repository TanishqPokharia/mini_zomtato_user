import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/repository/restaurant_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class GetRestaurantMenu
    implements UseCase<List<RestaurantMenuItem>, GetRestaurantDetailsParams> {
  final RestaurantRepository _repository;

  GetRestaurantMenu(this._repository);

  @override
  Future<Either<Failure, List<RestaurantMenuItem>>> call(
    GetRestaurantDetailsParams params,
  ) {
    return _repository.getRestaurantMenu(params.restaurantId);
  }
}

class GetRestaurantDetailsParams {
  final String restaurantId;

  GetRestaurantDetailsParams(this.restaurantId);
}
