import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoggingEvent>((event, emit) async {
      try {
        emit(LoginWithLoading());
        await Future.delayed(Duration(seconds: 3));
        if (event.userName == "yasser" && event.password == "1234") {
          emit(LoginWithSuccess());
        } else {
          throw Exception("User name or Password don't correct!");
        }
      } catch (e) {
        emit(LoginWithError(errorMessage: e.toString()));
      }
    });
  }
}
