import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_zomato_user/data/models/address/address.dart';
import 'package:mini_zomato_user/data/models/restaurant/restaurant.dart';
import 'package:mini_zomato_user/data/models/restaurant_menu_item/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/entities/order.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
abstract class OrderModel with _$OrderModel implements Order {
  const factory OrderModel({
    required String id,
    required String userId,
    required List<RestaurantModel> restaurants,
    required List<RestaurantMenuItemModel> items,
    required double totalAmount,
    required OrderStatus orderStatus,
    required DateTime placedOn,
    required AddressModel address,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
