import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';

abstract class CartItem {
  String get id;
  Restaurant get restaurant;
  List<RestaurantMenuItem> get menuItems;
}
