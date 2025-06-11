part of 'restaurant_list_bloc.dart';

@immutable
sealed class RestaurantListEvent {}

final class RestaurantListFetchEvent extends RestaurantListEvent {}
