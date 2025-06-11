import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/user_datasource.dart';
import 'package:mini_zomato_user/utils/failure.dart';

class UserDataSourceImpl implements UserDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  UserDataSourceImpl(this._firestore, this._auth);

  @override
  Future<Either<Failure, void>> addAddress(
    String userId,
    Map<String, dynamic> address,
  ) async {
    try {
      // if no addressed is already present, create a new document
      final userRef = _firestore.collection('addresses').doc(userId);
      final userSnapshot = await userRef.get();
      if (!userSnapshot.exists) {
        await userRef.set({
          'addresses': [address],
        }, SetOptions(merge: true));
        return Right(null);
      }
      // Add the new address to the user's addresses array
      await userRef.update({
        'addresses': FieldValue.arrayUnion([address]),
      });
      return Right(null);
    } catch (error) {
      log("Error adding address", error: error);
      return Left(Failure(message: "Failed to add address: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(
    String userId,
    String addressId,
  ) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      final userSnapshot = await userRef.get();

      final addresses =
          userSnapshot.data()?['addresses'] as List<dynamic>? ?? [];

      final updatedAddresses =
          addresses.where((address) => address['id'] != addressId).toList();
      await userRef.update({'addresses': updatedAddresses});
      return Right(null);
    } catch (error) {
      log("Error deleting address", error: error);
      return Left(Failure(message: "Failed to delete address: $error"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserAddresses(
    String userId,
  ) async {
    try {
      final userRef = _firestore.collection('addresses').doc(userId);
      final userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data();
        if (data != null && data.containsKey('addresses')) {
          return Right({'addresses': data['addresses']});
        } else {
          return Left(Failure(message: "No addresses found for user"));
        }
      } else {
        return Left(Failure(message: "No saved addresses"));
      }
    } catch (error) {
      log("Error fetching user addresses", error: error);
      return Left(Failure(message: "Failed to fetch user addresses"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserProfile() async {
    try {
      if (_auth.currentUser == null) {
        return Left(Failure(message: "Unauthenticated"));
      }

      return Right({
        'id': _auth.currentUser!.uid,
        'email': _auth.currentUser!.email,
        'name': _auth.currentUser!.displayName ?? '',
      });
    } catch (error) {
      log("Error fetching user profile", error: error);
      return Left(Failure(message: "Failed to fetch user profile"));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return Right(true);
      } else {
        return Right(false);
      }
    } catch (error) {
      log("Error checking user login status", error: error);
      return Left(Failure(message: "Failed to check user login status"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        return Right({
          'id': user.uid,
          'email': user.email,
          'name': user.displayName ?? '',
        });
      } else {
        return Left(Failure(message: "Login failed"));
      }
    } catch (error) {
      log("Error logging in", error: error);
      return Left(Failure(message: "Failed to login: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _auth.signOut();
      return Right(null);
    } catch (error) {
      log("Error logging out", error: error);
      return Left(Failure(message: "Failed to logout: $error"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: name);
        return Right({'id': user.uid, 'email': user.email, 'name': name});
      } else {
        return Left(Failure(message: "Sign up failed"));
      }
    } catch (error) {
      log("Error signing up", error: error);
      return Left(Failure(message: "Failed to sign up: $error"));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Map<String, dynamic>>>>> getUserOrders(
    String userId,
  ) async {
    try {
      log("Fetching orders for user: $userId");
      final ordersStream = _firestore
          .collection('orders')
          .orderBy('placedOn', descending: true)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) => doc.data()).toList();
          });

      return Right(ordersStream);
    } catch (error) {
      log("Error fetching user orders", error: error);
      return Left(Failure(message: "Failed to fetch user orders: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> addToOrders(
    String userId,
    Map<String, dynamic> order,
  ) async {
    try {
      final ordersCollection = _firestore.collection('orders');
      // create a new doc which has the fields userId and order details
      await ordersCollection.add({'userId': userId, ...order});
      return Right(null);
    } catch (error) {
      log("Error adding order", error: error, stackTrace: StackTrace.current);
      return Left(Failure(message: "Failed to add order: $error"));
    }
  }
}
