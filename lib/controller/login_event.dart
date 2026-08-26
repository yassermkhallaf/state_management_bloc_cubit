part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoggingEvent extends LoginEvent {
  final String userName;
  final String password;

  LoggingEvent({required this.userName, required this.password});
}
