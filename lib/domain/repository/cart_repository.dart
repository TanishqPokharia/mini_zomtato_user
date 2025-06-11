import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems(String userId);
  Future<Either<Failure, void>> addToCart(
    String userId,
    CartItem item,
    RestaurantMenuItem menuItem,
    Restaurant restaurant,
  );
  Future<Either<Failure, void>> removeFromCart(String userId, String itemId);
  Future<Either<Failure, void>> clearCart(String userId);
}
