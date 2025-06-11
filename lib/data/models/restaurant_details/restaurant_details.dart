import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_zomato_user/data/models/restaurant_menu_item/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_details.dart';

part 'restaurant_details.freezed.dart';
part 'restaurant_details.g.dart';

@freezed
abstract class RestaurantDetailsModel
    with _$RestaurantDetailsModel
    implements RestaurantDetails {
  const factory RestaurantDetailsModel({
    required String id,
    required String name,
    required String location,
    required List<RestaurantMenuItemModel> menu,
  }) = _RestaurantDetailsModel;

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsModelFromJson(json);
}
