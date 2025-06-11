part of 'menu_bloc.dart';

@immutable
sealed class MenuEvent {}

final class MenuFetchEvent extends MenuEvent {
  final String restaurantId;

  MenuFetchEvent(this.restaurantId);
}
