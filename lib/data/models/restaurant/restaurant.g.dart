// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    _RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$RestaurantModelToJson(_RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
    };
