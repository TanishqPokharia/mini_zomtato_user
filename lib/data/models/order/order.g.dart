// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  restaurants:
      (json['restaurants'] as List<dynamic>)
          .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  items:
      (json['items'] as List<dynamic>)
          .map(
            (e) => RestaurantMenuItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  orderStatus: $enumDecode(_$OrderStatusEnumMap, json['orderStatus']),
  placedOn: DateTime.parse(json['placedOn'] as String),
  address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrderModelToJson(_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'restaurants': instance.restaurants.map((r) => r.toJson()).toList(),
      'items': instance.items.map((i) => i.toJson()).toList(),
      'totalAmount': instance.totalAmount,
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus]!,
      'placedOn': instance.placedOn.toIso8601String(),
      'address': instance.address.toJson(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.accepted: 'accepted',
  OrderStatus.rejected: 'rejected',
  OrderStatus.picked: 'picked',
  OrderStatus.delivered: 'delivered',
};
