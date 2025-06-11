import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/cart_datasource.dart';
import 'package:mini_zomato_user/utils/failure.dart';

class CartDataSourceImpl implements CartDataSource {
  final FirebaseFirestore _firestore;
  CartDataSourceImpl(this._firestore);

  @override
  Future<Either<Failure, void>> addToCart(
    String userId,
    Map<String, dynamic> cartItem,
    Map<String, dynamic> menuItem,
    Map<String, dynamic> restaurant,
  ) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        // Cart exists, check if restaurant is already in the cart
        final data = cartSnapshot.data();
        if (data != null && data.containsKey('items')) {
          List<dynamic> items = List.from(data['items']);
          bool restaurantFound = false;

          for (int i = 0; i < items.length; i++) {
            // Check if this restaurant ID matches the new item's restaurant
            if (items[i]['restaurant']['id'] == restaurant['id']) {
              // Restaurant found, add menu item to its items list
              if (!items[i].containsKey('menuItems')) {
                items[i]['menuItems'] = [];
              }
              items[i]['menuItems'].add(menuItem);
              restaurantFound = true;
              break;
            }
          }

          if (!restaurantFound) {
            // Restaurant not found, create new cart item with restaurant and menu item
            items.add({
              'id': cartItem['id'],
              'restaurant': restaurant,
              'menuItems': [menuItem],
            });
          }

          // Update the cart with modified items
          await cartRef.update({'items': items});
        } else {
          // Items field doesn't exist, create it
          await cartRef.set({
            'items': [
              {
                'id': cartItem['id'],
                'restaurant': restaurant,
                'menuItems': [menuItem],
              },
            ],
          }, SetOptions(merge: true));
        }
      } else {
        // Cart doesn't exist, create it
        await cartRef.set({
          'items': [
            {
              'id': cartItem['id'],
              'restaurant': restaurant,
              'menuItems': [menuItem],
            },
          ],
        });
      }

      return Right(null);
    } catch (error) {
      log("Error adding item to cart", error: error);
      return Left(Failure(message: "Failed to add item to cart"));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(String userId) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      await cartRef.update({'items': []});
      return Right(null);
    } catch (error) {
      log("Error clearing cart", error: error);
      return Left(Failure(message: "Failed to clear cart"));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getCartItems(
    String userId,
  ) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      final cartSnapshot = await cartRef.get();
      if (cartSnapshot.exists) {
        final data = cartSnapshot.data();
        if (data != null && data.containsKey('items')) {
          return Right(List<Map<String, dynamic>>.from(data['items']));
        } else {
          return Left(Failure(message: "No items in cart"));
        }
      } else {
        return Left(Failure(message: "No Items in cart"));
      }
    } catch (error) {
      log("Error fetching cart items", error: error);
      return Left(Failure(message: "Failed to fetch cart items"));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(
    String userId,
    String itemId,
  ) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);
      await cartRef.update({
        'items': FieldValue.arrayRemove([
          {'id': itemId},
        ]),
      });
      return Right(null);
    } catch (error) {
      log("Error removing item from cart", error: error);
      return Left(Failure(message: "Failed to remove item from cart"));
    }
  }
}
