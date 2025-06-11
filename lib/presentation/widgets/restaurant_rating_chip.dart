import 'package:flutter/material.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class RestaurantRatingChip extends StatelessWidget {
  const RestaurantRatingChip({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.rs(8),
        vertical: context.rs(4),
      ),
      decoration: BoxDecoration(
        color: Colors.green[400 + restaurant.rating.toInt() * 100],
        borderRadius: BorderRadius.circular(context.rs(10)),
      ),
      child: Row(
        spacing: 4,
        children: [
          Text(
            "${restaurant.rating}",
            style: context.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),

          Icon(Icons.star, color: Colors.white, size: context.rs(20)),
        ],
      ),
    );
  }
}
