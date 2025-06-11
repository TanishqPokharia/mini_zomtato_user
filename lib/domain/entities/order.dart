import 'package:json_annotation/json_annotation.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';

abstract class Order {
  String get id;
  String get userId;
  List<Restaurant> get restaurants;
  List<RestaurantMenuItem> get items;
  double get totalAmount;
  OrderStatus get orderStatus;
  DateTime get placedOn;
  Address get address;
}

@JsonEnum()
enum OrderStatus { pending, accepted, rejected, picked, delivered }

@JsonEnum()
enum DeliveryStatus { picked, delivered }
