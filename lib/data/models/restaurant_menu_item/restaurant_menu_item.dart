import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';

part 'restaurant_menu_item.freezed.dart';
part 'restaurant_menu_item.g.dart';

@freezed
abstract class RestaurantMenuItemModel
    with _$RestaurantMenuItemModel
    implements RestaurantMenuItem {
  const factory RestaurantMenuItemModel({
    required String id,
    required String restaurantId,
    required String name,
    required double price,
    required String description,
    required MenuItemType menuItemType,
    required PalateType palateType,
  }) = _RestaurantMenuItemModel;

  factory RestaurantMenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuItemModelFromJson(json);
  factory RestaurantMenuItemModel.fromEntity(RestaurantMenuItem item) {
    return RestaurantMenuItemModel(
      id: item.id,
      restaurantId: item.restaurantId,
      name: item.name,
      price: item.price,
      description: item.description,
      menuItemType: item.menuItemType,
      palateType: item.palateType,
    );
  }
}
