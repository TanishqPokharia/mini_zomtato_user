import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_zomato_user/data/models/address/address.dart';
import 'package:mini_zomato_user/data/models/order/order.dart';
import 'package:mini_zomato_user/data/models/restaurant/restaurant.dart';
import 'package:mini_zomato_user/data/models/restaurant_menu_item/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/entities/order.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/usecases/add_to_orders.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_orders_stream.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_profile.dart';
import 'package:mini_zomato_user/main.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:uuid/uuid.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetUserProfile _getUserProfile;
  final GetUserOrdersStream _getUserOrdersStream;
  final AddToOrders _addToOrders;

  // final
  List<Order> _orders = [];
  OrdersBloc(this._getUserProfile, this._getUserOrdersStream, this._addToOrders)
    : super(OrdersInitial()) {
    on<OrdersAddEvent>((event, emit) async {
      final userDetails = await _getUserProfile(NoParams());
      final userId = userDetails.fold((failure) {
        emit(OrdersFailure(failure.message));
        return null;
      }, (details) => details.id);
      if (userId == null) return;
      final address = event.address;
      final totalAmount = event.items.fold(
        0.0,
        (sum, item) => sum + item.price,
      );
      final restaurants =
          event.restaurants.map((r) => RestaurantModel.fromEntity(r)).toList();
      final items =
          event.items
              .map((item) => RestaurantMenuItemModel.fromEntity(item))
              .toList();
      final order = OrderModel(
        id: Uuid().v4(),
        userId: userId,
        restaurants: restaurants,
        items: items,
        totalAmount: totalAmount,
        orderStatus: OrderStatus.pending,
        placedOn: DateTime.now(),
        address: AddressModel.fromEntity(address),
      );

      // update state locally
      _orders = [..._orders, order];
      emit(OrdersSuccess(_orders));

      // add to orders in the backend
      final result = await _addToOrders(
        AddToOrdersParams(userId: userId, order: order),
      );
      result.fold(
        (failure) {
          emit(OrdersSuccess(_orders..remove(order), message: failure.message));
        },
        (_) {
          // Successfully added to backend
          // Clear the cart after successful order placement
          getIt<CartBloc>().add(CartClearEvent());
        },
      );

      // userDetails.f
    });

    on<OrdersFetchEvent>((event, emit) async {
      emit(OrdersLoading());
      final userDetails = await _getUserProfile(NoParams());

      final userId = userDetails.fold((failure) {
        emit(OrdersFailure(failure.message));
        return null;
      }, (details) => details.id);
      if (userId == null) return;
      final orderStream = await _getUserOrdersStream(
        GetUserOrdersStreamParams(userId),
      );

      await orderStream.fold(
        (failure) async {
          emit(OrdersFailure(failure.message));
        },
        (stream) {
          // Instead of awaiting the stream result, we'll use the Bloc's
          // event handler to transform the stream events
          emit(OrdersLoading());
          return emit.forEach(
            stream,
            onData: (List<Order> orders) {
              _orders = [...orders];
              return OrdersSuccess(_orders);
            },
            onError:
                (error, _) => OrdersFailure("Failed to fetch orders: $error"),
          );
        },
      );
    });
  }
}
