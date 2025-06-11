import 'package:dartz/dartz.dart' show Either;
import 'package:mini_zomato_user/domain/entities/address.dart';
import 'package:mini_zomato_user/domain/entities/order.dart';
import 'package:mini_zomato_user/domain/entities/user.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signUp(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, List<Address>>> getUserAddresses(String userId);
  Future<Either<Failure, void>> addAddress(String userId, Address address);
  Future<Either<Failure, void>> deleteAddress(String userId, String addressId);
  Future<Either<Failure, Stream<List<Order>>>> getUserOrders(String userId);
  Future<Either<Failure, void>> addToOrders(String userId, Order order);
}
