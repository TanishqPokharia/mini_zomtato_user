import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/orders/orders_bloc.dart';
import 'package:mini_zomato_user/presentation/widgets/order_tile.dart';
import 'package:mini_zomato_user/utils/extensions/theme_extensions.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrdersBloc>().add(OrdersFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrdersFailure) {
              return Center(child: Text(state.message));
            } else if (state is OrdersSuccess) {
              final orders = state.orders;
              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    "No orders found",
                    style: context.textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderTile(order: order);
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
