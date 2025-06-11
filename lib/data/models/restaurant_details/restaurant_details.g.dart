// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantDetailsModel _$RestaurantDetailsModelFromJson(
  Map<String, dynamic> json,
) => _RestaurantDetailsModel(
  id: json['id'] as String,
  name: json['name'] as String,
  location: json['location'] as String,
  menu:
      (json['menu'] as List<dynamic>)
          .map(
            (e) => RestaurantMenuItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$RestaurantDetailsModelToJson(
  _RestaurantDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'location': instance.location,
  'menu': instance.menu,
};
