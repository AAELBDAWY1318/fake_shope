part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final User user;

  const SignUpEvent({required this.user});
}

class LoginEvent extends AuthEvent {
  final String email, password;

  const LoginEvent({required this.email, required this.password});
}
