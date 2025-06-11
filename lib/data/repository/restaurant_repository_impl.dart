import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/restaurant_datasource.dart';
import 'package:mini_zomato_user/data/models/restaurant/restaurant.dart';
import 'package:mini_zomato_user/data/models/restaurant_menu_item/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/repository/restaurant_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantDataSource _restaurantDataSource;
  RestaurantRepositoryImpl(this._restaurantDataSource);

  @override
  Future<Either<Failure, List<RestaurantMenuItem>>> getRestaurantMenu(
    String restaurantId,
  ) async {
    try {
      final result = await _restaurantDataSource.getRestaurantMenu(
        restaurantId,
      );
      return result.fold((failure) => Left(failure), (body) {
        final menuList = body['menu'] as List<dynamic>;
        final menu =
            menuList
                .map((item) => RestaurantMenuItemModel.fromJson(item))
                .toList();
        return Right(menu);
      });
    } catch (error) {
      log("Error fetching restaurant menu", error: error);
      return Left(Failure(message: "Failed to fetch restaurant menu: $error"));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      final result = await _restaurantDataSource.getRestaurants();
      return result.fold((failure) => Left(failure), (body) {
        final restaurantList = body['restaurants'] as List<dynamic>;
        final restaurants =
            restaurantList
                .map((item) => RestaurantModel.fromJson(item))
                .toList();
        return Right(restaurants);
      });
    } catch (error) {
      log("Error fetching restaurants", error: error);
      return Left(Failure(message: "Failed to fetch restaurants: $error"));
    }
  }
}
