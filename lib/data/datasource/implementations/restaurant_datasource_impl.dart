import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/restaurant_datasource.dart';
import 'package:mini_zomato_user/utils/failure.dart';

class RestaurantDataSourceImpl implements RestaurantDataSource {
  final FirebaseFirestore _firestore;
  RestaurantDataSourceImpl(this._firestore);
  @override
  Future<Either<Failure, Map<String, dynamic>>> getRestaurantMenu(
    String id,
  ) async {
    try {
      final menu = await _firestore.collection('menu').doc(id).get();
      final rawMenu = menu.data();
      if (rawMenu == null) {
        return Left(Failure(message: "Menu not available"));
      }
      final menuListWithoutRestaurantId = rawMenu['menu'] as List<dynamic>;
      final menuList =
          menuListWithoutRestaurantId.map((item) {
            item['restaurantId'] = rawMenu['restaurant_id'];
            return item;
          }).toList();
      return Right({'menu': menuList});
    } catch (error) {
      log("Error fetching restaurant menu", error: error);
      return Left(Failure(message: "Failed to fetch restaurant menu"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getRestaurants() async {
    try {
      final restaurantsCollection =
          await _firestore.collection('restaurants').get();
      final restaurantsDocs = restaurantsCollection.docs;
      final restaurants = restaurantsDocs.map((doc) => doc.data()).toList();
      return Right({'restaurants': restaurants});
    } catch (error) {
      log("Error fetching restaurants", error: error);
      return Left(Failure(message: "Failed to fetch restaurants"));
    }
  }
}
