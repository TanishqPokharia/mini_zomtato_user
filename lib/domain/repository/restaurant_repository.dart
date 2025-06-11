import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurants();
  Future<Either<Failure, List<RestaurantMenuItem>>> getRestaurantMenu(
    String restaurantId,
  );
}
