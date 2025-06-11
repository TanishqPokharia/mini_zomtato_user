import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_zomato_user/data/models/cart_item/cart_item.dart';
import 'package:mini_zomato_user/data/models/restaurant/restaurant.dart';
import 'package:mini_zomato_user/data/models/restaurant_menu_item/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/entities/cart_item.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/usecases/add_to_cart.dart';
import 'package:mini_zomato_user/domain/usecases/clear_cart.dart';
import 'package:mini_zomato_user/domain/usecases/get_cart_items.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_profile.dart';
import 'package:mini_zomato_user/domain/usecases/remove_from_cart.dart';
import 'package:mini_zomato_user/main.dart';
import 'package:mini_zomato_user/presentation/bloc/orders/orders_bloc.dart';
import 'package:mini_zomato_user/utils/no_params.dart';
import 'package:uuid/uuid.dart';

part './cart_event.dart';
part './cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> _cartItems = [];
  Address? _address;
  final ClearCart _clearCart;
  final AddToCart _addToCart;
  final GetCartItems _getCartItems;
  final RemoveFromCart _removeFromCart;
  final GetUserProfile _getUserProfile;
  CartBloc(
    this._clearCart,
    this._addToCart,
    this._getCartItems,
    this._removeFromCart,
    this._getUserProfile,
  ) : super(CartInitial()) {
    on<CartFetchEvent>((event, emit) async {
      emit(CartLoading());
      final userDetails = await _getUserProfile(NoParams());
      await userDetails.fold(
        (failure) {
          emit(CartFailure(failure.message));
        },
        (details) async {
          final userId = details.id;
          final cartItemsResult = await _getCartItems(
            GetCartItemsParams(userId: userId),
          );
          cartItemsResult.fold(
            (failure) {
              emit(CartFailure(failure.message));
            },
            (cartItems) {
              _cartItems = cartItems;
              emit(CartSuccess(_cartItems, _address));
            },
          );
        },
      );
    });

    on<CartAddEvent>((event, emit) async {
      final cartId = Uuid().v4();
      // manage local cart state
      final existingCartItemIndex = _cartItems.indexWhere(
        (item) => item.restaurant.id == event.restaurant.id,
      );

      if (existingCartItemIndex != -1) {
        // If the restaurant already exists in the cart, add the new item to it
        final updatedCartItems = List<CartItem>.from(_cartItems);
        final existingCartItem = updatedCartItems[existingCartItemIndex];

        // Create an updated cart item with the new menu item added
        final List<RestaurantMenuItemModel> updatedMenuItems = [
          ...existingCartItem.menuItems.map(
            (e) => RestaurantMenuItemModel.fromEntity(e),
          ),
          RestaurantMenuItemModel.fromEntity(event.restaurantMenuItem),
        ];

        updatedCartItems[existingCartItemIndex] = CartItemModel(
          id: existingCartItem.id,
          restaurant: RestaurantModel.fromEntity(existingCartItem.restaurant),
          menuItems: updatedMenuItems,
        );

        _cartItems = updatedCartItems;
      } else {
        // If the restaurant does not exist, create a new CartItem
        _cartItems.add(
          CartItemModel(
            id: cartId,
            restaurant: RestaurantModel.fromEntity(event.restaurant),
            menuItems: [
              RestaurantMenuItemModel.fromEntity(event.restaurantMenuItem),
            ],
          ),
        );
      }
      emit(CartSuccess(_cartItems, _address));

      // sync with backend
      final userDetails = await _getUserProfile(NoParams());
      await userDetails.fold(
        (failure) {
          emit(CartFailure(failure.message));
        },
        (details) async {
          final userId = details.id;
          final result = await _addToCart(
            AddToCartParams(
              userId: userId,
              cartItem: CartItemModel(
                id: cartId,
                restaurant: RestaurantModel.fromEntity(event.restaurant),
                menuItems: [
                  RestaurantMenuItemModel.fromEntity(event.restaurantMenuItem),
                ],
              ),
              restaurant: event.restaurant,
              menuItem: event.restaurantMenuItem,
            ),
          );
          result.fold(
            (failure) {
              emit(CartFailure(failure.message));
            },
            (_) {
              // Successfully added to backend
            },
          );
        },
      );
    });

    on<CartRemoveEvent>((event, emit) async {
      // manage local cart state
      final List<CartItem> filteredCartItems = [];
      for (final cartItem in _cartItems) {
        if (cartItem.id != event.cartItemId) {
          filteredCartItems.add(cartItem);
          continue;
        }
        final updatedItems =
            cartItem.menuItems
                .where((item) => item.id != event.menuItemId)
                .map((item) => RestaurantMenuItemModel.fromEntity(item))
                .toList();
        if (updatedItems.isNotEmpty) {
          filteredCartItems.add(
            CartItemModel(
              id: cartItem.id,
              restaurant: RestaurantModel.fromEntity(cartItem.restaurant),
              menuItems: updatedItems,
            ),
          );
        }
      }
      _cartItems = [...filteredCartItems];
      emit(CartSuccess(_cartItems, _address));

      // sync with backend
      final userDetails = await _getUserProfile(NoParams());
      userDetails.fold(
        (failure) {
          emit(CartFailure(failure.message));
        },
        (details) async {
          final userId = details.id;
          final result = await _removeFromCart(
            RemoveFromCartParams(userId, event.menuItemId),
          );
          result.fold(
            (failure) {
              emit(CartFailure(failure.message));
            },
            (_) {
              // Successfully removed from backend
            },
          );
        },
      );
    });

    on<CartAddressSetEvent>((event, emit) async {
      // manage local cart state
      _address = event.address;
      emit(CartSuccess(_cartItems, _address));
    });

    on<CartClearEvent>((event, emit) async {
      // manage local cart state
      _cartItems = [];
      _address = null;
      emit(CartSuccess(_cartItems, _address));
      // sync with backend
      final userDetails = await _getUserProfile(NoParams());
      userDetails.fold(
        (failure) {
          emit(CartFailure(failure.message));
        },
        (details) async {
          final userId = details.id;
          final result = await _clearCart(ClearCartParams(userId));
          result.fold(
            (failure) {
              emit(CartFailure(failure.message));
            },
            (_) {
              // Successfully cleared cart in backend
            },
          );
        },
      );
    });

    on<CartCheckoutEvent>((event, emit) async {
      if (_address == null) {
        emit(
          CartCheckoutFailure(
            _cartItems,
            _address,
            "Please select an address to proceed",
          ),
        );
        return;
      }
      emit(CartCheckoutLoading(_cartItems, _address!));
      assert(_address != null);
      assert(_cartItems.isNotEmpty);

      // clear cart and add to previous orders
      final restaurants = _cartItems.map((item) => item.restaurant).toList();
      final restaurantMenuItems =
          _cartItems.map((item) => item.menuItems).expand((e) => e).toList();
      getIt<OrdersBloc>().add(
        OrdersAddEvent(_address!, restaurants, restaurantMenuItems),
      );
      _cartItems = [];
      _address = null;
      emit(CartCheckoutSuccess());
    });
  }
}
