import 'package:flutter/material.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/presentation/screens/restaurant_details_screen.dart';
import 'package:mini_zomato_user/presentation/widgets/restaurant_rating_chip.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(context.rs(8)),
          child: Column(
            children: [
              Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
                height: context.rs(200),
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.rs(300),
                          child: Text(
                            restaurant.name,
                            style: context.textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        RestaurantRatingChip(restaurant: restaurant),
                      ],
                    ),
                    Text(
                      restaurant.location,
                      style: context.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
