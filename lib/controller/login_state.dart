part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginWithLoading extends LoginState {

}

final class LoginWithSuccess extends LoginState {

}
final class LoginWithError extends LoginState{
  final String errorMessage;

  LoginWithError({required this.errorMessage});
}
