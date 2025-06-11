part of 'menu_bloc.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}

final class MenuLoading extends MenuState {}

final class MenuSuccess extends MenuState {
  final List<RestaurantMenuItem> menuItems;

  MenuSuccess(this.menuItems);
}

final class MenuFailure extends MenuState {
  final String message;

  MenuFailure(this.message);
}
