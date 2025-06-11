import 'package:flutter/material.dart';
import 'package:mini_zomato_user/domain/entities/order.dart';
import 'package:mini_zomato_user/presentation/widgets/palate_indicator.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';
import 'package:mini_zomato_user/utils/format_date.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: context.rs(16),
        vertical: context.rs(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.rs(20),
              vertical: context.rs(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(label: Text(order.orderStatus.name.toUpperCase())),
                    Text("Placed on: ${formatDate(order.placedOn)}"),
                  ],
                ),
                Text(
                  "Total: ₹${order.totalAmount}",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.rs(20),
              vertical: context.rs(10),
            ),
            child: Text("Restaurants"),
          ),
          Column(
            children: [
              ...order.restaurants.map((restaurant) {
                return ListTile(
                  leading: Container(
                    width: context.rs(50),
                    height: context.rs(50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(restaurant.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    restaurant.name,
                    style: context.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    restaurant.location,
                    style: context.textTheme.bodyMedium,
                  ),
                );
              }),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.rs(20),
              vertical: context.rs(10),
            ),
            child: Text("Food Items"),
          ),
          Column(
            children: [
              ...order.items.map((item) {
                return ListTile(
                  leading: PalateIndicator(palateType: item.palateType),
                  title: Text(item.name),
                  subtitle: Text(
                    "₹${item.price.toStringAsFixed(2)}",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
