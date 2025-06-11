import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/domain/usecases/get_restaurant_menu.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetRestaurantMenu _getRestaurantMenu;
  MenuBloc(this._getRestaurantMenu) : super(MenuInitial()) {
    on<MenuFetchEvent>((event, emit) async {
      emit(MenuLoading());
      final menuResult = await _getRestaurantMenu(
        GetRestaurantDetailsParams(event.restaurantId),
      );
      menuResult.fold(
        (failure) {
          emit(MenuFailure(failure.message));
        },
        (menuItems) {
          emit(MenuSuccess(menuItems));
        },
      );
    });
  }
}
