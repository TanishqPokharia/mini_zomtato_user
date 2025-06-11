import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/repository/cart_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';
import 'package:mini_zomato_user/utils/usecase.dart';

class AddToCart implements UseCase<void, AddToCartParams> {
  final CartRepository _repository;

  AddToCart(this._repository);

  @override
  Future<Either<Failure, void>> call(AddToCartParams params) {
    return _repository.addToCart(
      params.userId,
      params.cartItem,
      params.menuItem,
      params.restaurant,
    );
  }
}

class AddToCartParams {
  final String userId;
  final CartItem cartItem;
  final RestaurantMenuItem menuItem;
  final Restaurant restaurant;

  const AddToCartParams({
    required this.userId,
    required this.cartItem,
    required this.menuItem,
    required this.restaurant,
  });
}
