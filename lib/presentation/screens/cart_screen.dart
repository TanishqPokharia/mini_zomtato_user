import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/widgets/address_selection_sheet.dart';
import 'package:mini_zomato_user/presentation/widgets/address_tile.dart';
import 'package:mini_zomato_user/presentation/widgets/cart_item_tile.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Access the dummy cart items
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          actions: [
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ClearCartDialog();
                  },
                );
              },
              icon: Icon(
                Icons.remove_shopping_cart_outlined,
                color: Colors.redAccent,
              ),

              label: Text(
                "Clear Cart",
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.redAccent,
                ),
              ),
            ),
            SizedBox(width: context.rs(20)),
          ],
        ),
        persistentFooterButtons: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartCheckoutLoading) {
                return CartCheckoutLoadingIndicator();
              }

              if ((state is! CartSuccess)) {
                return const SizedBox();
              }

              bool isCartEmpty = state.cartItems.isEmpty;

              if (isCartEmpty) {
                return SizedBox();
              }

              return SizedBox(
                width: double.infinity,
                height: context.rs(80),
                child: FilledButton(
                  onPressed: () {
                    if (state.address == null) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        builder: (context) => const AddressSelectionSheet(),
                      );
                      return;
                    }

                    context.read<CartBloc>().add(CartCheckoutEvent());
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    state.address == null ? "Select Address" : "Checkout",
                    style: context.textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
            if (state is CartCheckoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
            if (state is CartCheckoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    "Checkout successful!",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is CartFailure) {
              return Center(
                child: Text(state.message, style: context.textTheme.bodyLarge),
              );
            }

            if (state is CartCheckoutSuccess) {
              return Center(
                child: Text(
                  "Add items to checkout!",
                  style: context.textTheme.bodyLarge!.copyWith(),
                ),
              );
            }

            if (state is CartSuccess || state is CartCheckoutLoading) {
              List<CartItem> cartItems = [];
              Address? address;
              if (state is CartSuccess) {
                cartItems = state.cartItems;
                address = state.address;
              } else if (state is CartCheckoutLoading) {
                cartItems = state.cartItems;
                address = state.address;
              }

              if (cartItems.isEmpty) {
                return Center(
                  child: Text(
                    "Add items to checkout!",
                    style: context.textTheme.bodyLarge,
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    CartItemsListView(cartItems: cartItems),
                    if (address != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: context.rs(20)),
                        child: SelectedAddressCard(address: address),
                      ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: context.rs(20)),
                      child: CartTotalCard(cartItems: cartItems),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class CartCheckoutLoadingIndicator extends StatelessWidget {
  const CartCheckoutLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.rs(80),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}

class ClearCartDialog extends StatelessWidget {
  const ClearCartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Clear Cart"),
      icon: const Icon(Icons.warning, color: Colors.redAccent),
      content: const Text("Are you sure you want to clear the cart?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                if (state is! CartSuccess || state.cartItems.isEmpty) {
                  Navigator.of(context).pop();
                  return;
                }
                context.read<CartBloc>().add(CartClearEvent());
                Navigator.of(context).pop();
              },
              child: const Text("Clear"),
            );
          },
        ),
      ],
    );
  }
}

class SelectedAddressCard extends StatelessWidget {
  final Address address;
  const SelectedAddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(context.rs(20)),
            child: Text(
              "Selected Address",
              style: context.textTheme.titleLarge,
            ),
          ),
          AddressTile(
            address: address,
            onAddressSelected: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const AddressSelectionSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({super.key, required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      separatorBuilder: (context, index) => SizedBox(height: context.rs(10)),
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return CartItemTile(cartItem: cartItem);
      },
    );
  }
}

class CartTotalCard extends StatelessWidget {
  const CartTotalCard({super.key, required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.rs(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total", style: context.textTheme.bodyLarge),
            Text(
              "₹${cartItems.fold(0.0, (total, item) => total + item.menuItems.fold(0.0, (sum, menuItem) => sum + menuItem.price)).toStringAsFixed(2)}",
              style: context.textTheme.bodyLarge!.copyWith(
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
