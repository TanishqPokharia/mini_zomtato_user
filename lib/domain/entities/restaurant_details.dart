import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';

abstract class RestaurantDetails {
  String get id;
  String get name;
  String get location;
  List<RestaurantMenuItem> get menu;
}
