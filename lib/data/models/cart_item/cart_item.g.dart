// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      id: json['id'] as String,
      restaurant: RestaurantModel.fromJson(
        json['restaurant'] as Map<String, dynamic>,
      ),
      menuItems:
          (json['menuItems'] as List<dynamic>)
              .map(
                (e) =>
                    RestaurantMenuItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant': instance.restaurant,
      'menuItems': instance.menuItems,
    };
