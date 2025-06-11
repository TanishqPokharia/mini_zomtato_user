import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_zomato_user/data/datasource/implementations/cart_datasource_impl.dart';
import 'package:mini_zomato_user/data/datasource/implementations/restaurant_datasource_impl.dart';
import 'package:mini_zomato_user/data/datasource/implementations/user_datasource_impl.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/cart_datasource.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/restaurant_datasource.dart';
import 'package:mini_zomato_user/data/datasource/interfaces/user_datasource.dart';
import 'package:mini_zomato_user/data/repository/cart_repository_impl.dart';
import 'package:mini_zomato_user/data/repository/restaurant_repository_impl.dart';
import 'package:mini_zomato_user/data/repository/user_repository_impl.dart';
import 'package:mini_zomato_user/domain/repository/cart_repository.dart';
import 'package:mini_zomato_user/domain/repository/restaurant_repository.dart';
import 'package:mini_zomato_user/domain/repository/user_repository.dart';
import 'package:mini_zomato_user/domain/usecases/add_address.dart';
import 'package:mini_zomato_user/domain/usecases/add_to_cart.dart';
import 'package:mini_zomato_user/domain/usecases/add_to_orders.dart';
import 'package:mini_zomato_user/domain/usecases/clear_cart.dart';
import 'package:mini_zomato_user/domain/usecases/delete_address.dart';
import 'package:mini_zomato_user/domain/usecases/get_cart_items.dart';
import 'package:mini_zomato_user/domain/usecases/get_restaurant_menu.dart';
import 'package:mini_zomato_user/domain/usecases/get_restaurants.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_addresses.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_orders_stream.dart';
import 'package:mini_zomato_user/domain/usecases/get_user_profile.dart';
import 'package:mini_zomato_user/domain/usecases/is_user_logged_in.dart';
import 'package:mini_zomato_user/domain/usecases/login.dart';
import 'package:mini_zomato_user/domain/usecases/logout.dart';
import 'package:mini_zomato_user/domain/usecases/remove_from_cart.dart';
import 'package:mini_zomato_user/domain/usecases/sign_up.dart';
import 'package:mini_zomato_user/presentation/bloc/address/address_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/auth/auth_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/cart/cart_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/menu/menu_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/orders/orders_bloc.dart';
import 'package:mini_zomato_user/presentation/bloc/restaurant/restaurant_list_bloc.dart';

void registerDependencies(GetIt getIt) {
  // register firebase services
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //register datasources
  getIt.registerLazySingleton<CartDataSource>(
    () => CartDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<UserDataSource>(
    () => UserDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<RestaurantDataSource>(
    () => RestaurantDataSourceImpl(getIt()),
  );

  // register repositories
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(getIt()),
  );

  // register use cases
  getIt.registerFactory(() => GetUserProfile(getIt()));
  getIt.registerFactory(() => GetUserAddresses(getIt()));
  getIt.registerFactory(() => GetUserOrdersStream(getIt()));
  getIt.registerFactory(() => GetRestaurantMenu(getIt()));
  getIt.registerFactory(() => AddToOrders(getIt()));
  getIt.registerFactory(() => ClearCart(getIt()));
  getIt.registerFactory(() => AddAddress(getIt()));
  getIt.registerFactory(() => AddToCart(getIt()));
  getIt.registerFactory(() => DeleteAddress(getIt()));
  getIt.registerFactory(() => GetCartItems(getIt()));
  getIt.registerFactory(() => GetRestaurants(getIt()));
  getIt.registerFactory(() => IsUserLoggedIn(getIt()));
  getIt.registerFactory(() => Login(getIt()));
  getIt.registerFactory(() => Logout(getIt()));
  getIt.registerFactory(() => RemoveFromCart(getIt()));
  getIt.registerFactory(() => SignUp(getIt()));

  // register blocs
  getIt.registerLazySingleton(
    () => CartBloc(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => OrdersBloc(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => AddressBloc(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => MenuBloc(getIt()));
  getIt.registerLazySingleton(() => RestaurantListBloc(getIt()));
  getIt.registerLazySingleton(() => AuthBloc(getIt(), getIt(), getIt()));
}
