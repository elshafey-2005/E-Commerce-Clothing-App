
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 1)); // Simulate network latency

      // Temporarily accept any login
      emit(LoginSuccess());

    });
  }
}
