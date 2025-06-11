import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/widgets/palate_indicator.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class CartMenuItemTile extends StatelessWidget {
  const CartMenuItemTile({
    super.key,
    required this.item,
    required this.cartItem,
  });

  final RestaurantMenuItem item;
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PalateIndicator(palateType: item.palateType),
        SizedBox(width: context.rs(20)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(item.name, style: context.textTheme.bodySmall)],
          ),
        ),
        Text(
          "₹${item.price.toStringAsFixed(2)}",
          style: context.textTheme.bodyMedium!.copyWith(
            color: Colors.redAccent,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<CartBloc>().add(CartRemoveEvent(cartItem.id, item.id));
          },
          icon: Icon(Icons.delete_outline, color: Colors.red),
        ),
      ],
    );
  }
}
