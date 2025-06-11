import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_zomato_user/domain/usecases/is_user_logged_in.dart';
import 'package:mini_zomato_user/domain/usecases/login.dart';
import 'package:mini_zomato_user/domain/usecases/sign_up.dart';
import 'package:mini_zomato_user/utils/no_params.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final SignUp _signUp;
  final IsUserLoggedIn _isUserLoggedIn;
  AuthBloc(this._login, this._signUp, this._isUserLoggedIn) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      final loginResult = await _login(
        LoginParams(email: event.email, password: event.password),
      );
      loginResult.fold(
        (failure) {
          emit(AuthFailure(failure.message));
        },
        (user) {
          emit(AuthSuccess());
        },
      );
    });

    on<AuthCheckEvent>((event,emit) async {
      emit(AuthLoading());
      final isLoggedIn = await _isUserLoggedIn(NoParams());
      isLoggedIn.fold(
        (failure) {
          emit(AuthFailure(failure.message));
        },
        (isLoggedIn) {
          if (isLoggedIn) {
            emit(AuthLoggedIn());
          } else {
            emit(AuthNotLoggedIn("User is not logged in"));
          }
        },
      );

    });
  }
}
