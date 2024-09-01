part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class SignUpWaiting extends AuthState {}

class SignUpSuccess extends AuthState {
  final String token;

  const SignUpSuccess({required this.token});
}

class SignUpFailure extends AuthState {
  final String message;

  const SignUpFailure({required this.message});
}

class LoginWaiting extends AuthState {}

class LoginSuccess extends AuthState {
  final String token;

  const LoginSuccess({required this.token});
}

class LoginFailure extends AuthState {
  final String message;

  const LoginFailure({required this.message});
}
