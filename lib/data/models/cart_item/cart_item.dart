import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';

import '../restaurant/restaurant.dart';
import '../restaurant_menu_item/restaurant_menu_item.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItemModel with _$CartItemModel implements CartItem {
  const factory CartItemModel({
    required String id,
    required RestaurantModel restaurant,
    required List<RestaurantMenuItemModel> menuItems,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      id: item.id,
      restaurant: RestaurantModel.fromEntity(item.restaurant),
      menuItems:
          item.menuItems
              .map((menuItem) => RestaurantMenuItemModel.fromEntity(menuItem))
              .toList(),
    );
  }
}
