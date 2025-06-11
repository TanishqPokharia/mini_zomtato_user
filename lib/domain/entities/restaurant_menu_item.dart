import 'package:json_annotation/json_annotation.dart';

abstract class RestaurantMenuItem {
  String get id;
  String get restaurantId;
  String get name;
  String get description;
  double get price;
  MenuItemType get menuItemType;
  PalateType get palateType;
}

@JsonEnum()
enum MenuItemType { appetizer, mainCourse, dessert, beverage }

@JsonEnum()
enum PalateType { vegetarian, nonVegetarian }
