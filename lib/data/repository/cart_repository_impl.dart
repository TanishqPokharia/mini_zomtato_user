import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/cart_datasource.dart';
import 'package:mini_zomato_user/data/models/cart_item/cart_item.dart';
import 'package:mini_zomato_user/data/models/restaurant/restaurant.dart';
import 'package:mini_zomato_user/data/models/restaurant_menu_item/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/repository/cart_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource _cartDataSource;
  CartRepositoryImpl(this._cartDataSource);

  @override
  Future<Either<Failure, void>> addToCart(
    String userId,
    CartItem item,
    RestaurantMenuItem menuItem,
    Restaurant restaurant,
  ) async {
    try {
      final itemData = (item as CartItemModel).toJson();
      final menuItemData = (menuItem as RestaurantMenuItemModel).toJson();
      final restaurantData = (restaurant as RestaurantModel).toJson();

      final result = await _cartDataSource.addToCart(
        userId,
        itemData,
        menuItemData,
        restaurantData,
      );
      return result;
    } catch (error) {
      log("Error modeling cart item", error: error);
      return Left(Failure(message: "Failed to add item to cart: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(String userId) async {
    try {
      final result = await _cartDataSource.clearCart(userId);
      return result;
    } catch (error) {
      log("Error clearing cart", error: error);
      return Left(Failure(message: "Failed to clear cart: $error"));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems(String userId) async {
    try {
      final result = await _cartDataSource.getCartItems(userId);
      return result.fold((failure) => Left(failure), (items) {
        return Right(
          items.map((item) => CartItemModel.fromJson(item)).toList(),
        );
      });
    } catch (error) {
      log("Error modeling cart items", error: error);
      return Left(Failure(message: "Failed to fetch cart items: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(
    String userId,
    String itemId,
  ) async {
    try {
      final result = await _cartDataSource.removeFromCart(userId, itemId);
      return result;
    } catch (error) {
      log("Error removing item from cart", error: error);
      return Left(Failure(message: "Failed to remove item from cart: $error"));
    }
  }
}
