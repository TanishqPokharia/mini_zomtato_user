part of 'restaurant_list_bloc.dart';

@immutable
sealed class RestaurantListState {}

final class RestaurantListInitial extends RestaurantListState {}

final class RestaurantListLoading extends RestaurantListState {}

final class RestaurantListSuccess extends RestaurantListState {
  final List<Restaurant> restaurants;
  final String message;

  RestaurantListSuccess(this.restaurants, {this.message = ''});
}

final class RestaurantListFailure extends RestaurantListState {
  final String message;

  RestaurantListFailure(this.message);
}
