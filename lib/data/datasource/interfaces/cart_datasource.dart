import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class CartDataSource {
  Future<Either<Failure, List<Map<String, dynamic>>>> getCartItems(
    String userId,
  );
  Future<Either<Failure, void>> addToCart(
    String userId,
    Map<String, dynamic> cartItem,
    Map<String, dynamic> menuItem,
    Map<String, dynamic> restaurant,
  );
  Future<Either<Failure, void>> removeFromCart(String userId, String itemId);
  Future<Either<Failure, void>> clearCart(String userId);
}
