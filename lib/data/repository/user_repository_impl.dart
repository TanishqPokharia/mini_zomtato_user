import 'dart:developer';

import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:mini_zomato_user/data/datasource/interfaces/user_datasource.dart';
import 'package:mini_zomato_user/data/models/address/address.dart';
import 'package:mini_zomato_user/data/models/order/order.dart';
import 'package:mini_zomato_user/data/models/user/user.dart';
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/entities/order.dart';
import 'package:mini_zomato_user/domain/entities/user.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/utils/failure.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;
  UserRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> addAddress(
    String userId,
    Address address,
  ) async {
    try {
      final addressData = (address as AddressModel).toJson();
      final result = await _dataSource.addAddress(userId, addressData);
      return result;
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
      final result = await _dataSource.deleteAddress(userId, addressId);
      return result;
    } catch (error) {
      log("Error deleting address", error: error);
      return Left(Failure(message: "Failed to delete address: $error"));
    }
  }

  @override
  Future<Either<Failure, List<Address>>> getUserAddresses(String userId) async {
    try {
      final result = await _dataSource.getUserAddresses(userId);
      return result.fold((failure) => Left(failure), (body) {
        final addressList = body['addresses'] as List<dynamic>;
        final addresses =
            addressList.map((item) => AddressModel.fromJson(item)).toList();
        return Right(addresses);
      });
    } catch (error) {
      log("Error modeling user addresses", error: error);
      return Left(Failure(message: "Failed to fetch user addresses: $error"));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      final isLoggedIn = await _dataSource.isUserLoggedIn();
      return isLoggedIn;
    } catch (error) {
      log("Error checking user login status", error: error);
      return Left(
        Failure(message: "Failed to check user login status: $error"),
      );
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final result = await _dataSource.login(email, password);
      return result.fold((failure) => Left(failure), (body) {
        final user = UserModel.fromJson(body);
        return Right(user);
      });
    } catch (error) {
      log("Error logging in", error: error);
      return Left(Failure(message: "Failed to log in: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await _dataSource.logout();
      return result;
    } catch (error) {
      log("Error logging out", error: error);
      return Left(Failure(message: "Failed to log out: $error"));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await _dataSource.signUp(name, email, password);
      return result.fold((failure) => Left(failure), (body) {
        final user = UserModel.fromJson(body);
        return Right(user);
      });
    } catch (error) {
      log("Error signing up", error: error);
      return Left(Failure(message: "Failed to sign up: $error"));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    try {
      final result = await _dataSource.getUserProfile();
      return result.fold((failure) => Left(failure), (body) {
        final user = UserModel.fromJson(body);
        return Right(user);
      });
    } catch (error) {
      log("Error fetching user profile", error: error);
      return Left(Failure(message: "Failed to fetch user profile: $error"));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Order>>>> getUserOrders(
    String userId,
  ) async {
    try {
      final result = await _dataSource.getUserOrders(userId);
      return result.fold(
        (failure) => Left(failure),
        (stream) => Right(
          stream.map((orders) {
            return orders.map((order) => OrderModel.fromJson(order)).toList();
          }),
        ),
      );
    } catch (error) {
      log("Error fetching user orders", error: error);
      return Left(Failure(message: "Failed to fetch user orders: $error"));
    }
  }

  @override
  Future<Either<Failure, void>> addToOrders(String userId, Order order) async {
    try {
      final orderData = (order as OrderModel).toJson();
      log(orderData.toString());
      final result = await _dataSource.addToOrders(userId, orderData);
      return result;
    } catch (error) {
      log("Error modeling adding order", error: error);
      return Left(Failure(message: "Failed to add order: $error"));
    }
  }
}
