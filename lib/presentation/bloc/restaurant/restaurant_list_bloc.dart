import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_zomato_user/domain/entities/restaurant.dart';
import 'package:mini_zomato_user/domain/usecases/get_restaurants.dart';
import 'package:mini_zomato_user/utils/no_params.dart';

part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  final GetRestaurants _getRestaurants;
  RestaurantListBloc(this._getRestaurants) : super(RestaurantListInitial()) {
    on<RestaurantListFetchEvent>((event, emit) async {
      emit(RestaurantListLoading());
      final restaurantsResult = await _getRestaurants(NoParams());
      restaurantsResult.fold(
        (failure) {
          emit(RestaurantListFailure(failure.message));
        },
        (restaurants) {
          emit(RestaurantListSuccess(restaurants));
        },
      );
    });
  }
}
