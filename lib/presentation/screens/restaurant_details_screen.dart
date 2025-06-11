import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/menu/menu_bloc.dart';
import 'package:mini_zomato_user/presentation/screens/home_screen.dart';
import 'package:mini_zomato_user/presentation/widgets/restaurant_rating_chip.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MenuBloc>().add(MenuFetchEvent(widget.restaurant.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: [CartFooter()],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(),
            SliverPersistentHeader(
              pinned: true,
              delegate: RestaurantDetailsHeaderDelegate(
                restaurant: widget.restaurant,
                minHeight: context.rs(120),
                maxHeight: context.rs(400),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 16,
                ),
                child: Text("Menu", style: context.textTheme.headlineMedium),
              ),
            ),
            BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is MenuLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is MenuFailure) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)),
                  );
                } else if (state is MenuSuccess) {
                  final menuItems = state.menuItems;
                  if (menuItems.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "No items available in the menu",
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = menuItems[index];
                      return RestaurantMenuTile(
                        item: item,
                        onAddToCart: () {
                          context.read<CartBloc>().add(
                            CartAddEvent(widget.restaurant, item),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${item.name} added to cart",
                                style: context.textTheme.bodyMedium,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    }, childCount: menuItems.length),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 200),
            ), // Spacer at bottom
          ],
        ),
      ),
    );
  }
}

class RestaurantMenuTile extends StatelessWidget {
  final void Function()? onAddToCart;

  const RestaurantMenuTile({super.key, required this.item, this.onAddToCart});

  final RestaurantMenuItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '₹${item.price.toStringAsFixed(2)}',
            style: context.textTheme.bodyMedium!.copyWith(
              color: Colors.redAccent,
            ),
          ),
          IconButton(
            onPressed: onAddToCart,
            icon: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
    );
  }
}

// ... (RestaurantDetailsHeaderDelegate remains the same)

class RestaurantDetailsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Restaurant restaurant;
  final double minHeight;
  final double maxHeight;

  RestaurantDetailsHeaderDelegate({
    required this.restaurant,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(covariant RestaurantDetailsHeaderDelegate oldDelegate) {
    return restaurant != oldDelegate.restaurant ||
        minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Clamp the current height between min and max to avoid invalid BoxConstraints
    final double currentHeight = (maxExtent - shrinkOffset).clamp(
      minExtent,
      maxExtent,
    );

    return SizedBox(
      height: currentHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(restaurant.imageUrl, fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                context.rs(16),
                context.rs(16),
                context.rs(16),
                context.rs(20),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(context.rs(24)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      RestaurantRatingChip(restaurant: restaurant),
                    ],
                  ),
                  SizedBox(height: context.rs(8)),
                  Row(
                    children: [
                      Icon(Icons.pin_drop, size: context.rs(20)),
                      SizedBox(width: context.rs(6)),
                      Expanded(
                        child: Text(
                          restaurant.location,
                          style: context.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
