import 'package:dartz/dartz.dart';
import 'package:mini_zomato_user/utils/failure.dart';

abstract class UserDataSource {
  Future<Either<Failure, Map<String, dynamic>>> signUp(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, Map<String, dynamic>>> login(
    String email,
    String password,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Map<String, dynamic>>> getUserProfile();
  Future<Either<Failure, Map<String, dynamic>>> getUserAddresses(String userId);
  Future<Either<Failure, void>> addAddress(
    String userId,
    Map<String, dynamic> address,
  );
  Future<Either<Failure, void>> deleteAddress(String userId, String addressId);
  Future<Either<Failure, bool>> isUserLoggedIn();
  Future<Either<Failure, Stream<List<Map<String, dynamic>>>>> getUserOrders(
    String userId,
  );
  Future<Either<Failure, void>> addToOrders(
    String userId,
    Map<String, dynamic> order,
  );
}
