// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantMenuItemModel _$RestaurantMenuItemModelFromJson(
  Map<String, dynamic> json,
) => _RestaurantMenuItemModel(
  id: json['id'] as String,
  restaurantId: json['restaurantId'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  description: json['description'] as String,
  menuItemType: $enumDecode(_$MenuItemTypeEnumMap, json['menuItemType']),
  palateType: $enumDecode(_$PalateTypeEnumMap, json['palateType']),
);

Map<String, dynamic> _$RestaurantMenuItemModelToJson(
  _RestaurantMenuItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'restaurantId': instance.restaurantId,
  'name': instance.name,
  'price': instance.price,
  'description': instance.description,
  'menuItemType': _$MenuItemTypeEnumMap[instance.menuItemType]!,
  'palateType': _$PalateTypeEnumMap[instance.palateType]!,
};

const _$MenuItemTypeEnumMap = {
  MenuItemType.appetizer: 'appetizer',
  MenuItemType.mainCourse: 'mainCourse',
  MenuItemType.dessert: 'dessert',
  MenuItemType.beverage: 'beverage',
};

const _$PalateTypeEnumMap = {
  PalateType.vegetarian: 'vegetarian',
  PalateType.nonVegetarian: 'nonVegetarian',
};
