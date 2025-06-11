import 'package:flutter/material.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/presentation/widgets/cart_menu_item_tile.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.rs(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cartItem.restaurant.name, style: context.textTheme.bodyLarge),
            Text(
              cartItem.restaurant.location,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: cartItem.menuItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, itemIndex) {
                final item = cartItem.menuItems[itemIndex];
                return CartMenuItemTile(item: item, cartItem: cartItem);
              },
            ),
          ],
        ),
      ),
    );
  }
}
