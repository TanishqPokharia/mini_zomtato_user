import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/restaurant/restaurant_list_bloc.dart';
import 'package:mini_zomato_user/presentation/screens/cart_screen.dart';
import 'package:mini_zomato_user/presentation/screens/orders_screen.dart';
import 'package:mini_zomato_user/presentation/widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantListBloc>().add(RestaurantListFetchEvent());
    context.read<CartBloc>().add(CartFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Mini Zomato')),
        persistentFooterButtons: [
          CartFooter(),
        ],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Mini Zomato',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text('Cart'),
                trailing: Icon(Icons.shopping_basket),
                onTap: () {
                  // Navigate to cart screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
                },
              ),
              ListTile(
                title: const Text("My Orders"),
                onTap: () {
                  // Navigate to orders screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => OrdersScreen()),
                  );
                },
                trailing: Icon(Icons.history),
              ),
            ],
          ),
        ),
        body: BlocConsumer<RestaurantListBloc, RestaurantListState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is RestaurantListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RestaurantListFailure) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<RestaurantListBloc>().add(
                    RestaurantListFetchEvent(),
                  );
                },
                child: SingleChildScrollView(
                  child: Center(child: Text(state.message)),
                ),
              );
            } else if (state is RestaurantListSuccess) {
              final List<Restaurant> restaurants = state.restaurants;
              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class CartFooter extends StatelessWidget {
  const CartFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is! CartSuccess) return SizedBox();
        if (state.cartItems.isEmpty) {
          return SizedBox();
        }

        final itemCount = state.cartItems.fold<int>(
          0,
          (previousValue, cartItem) =>
              previousValue + cartItem.menuItems.length,
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$itemCount Item(s) Waiting!'),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen()),
                );
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text("View Cart"),
            ),
          ],
        );
      },
    );
  }
}
