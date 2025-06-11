import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class RestaurantDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getRestaurants();
  Future<Either<Failure, Map<String, dynamic>>> getRestaurantMenu(String id);
}
