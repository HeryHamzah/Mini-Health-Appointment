part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPasswordRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordRequested(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class CheckLoginStatusRequested extends AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserType userType;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object> get props => [name, email, password, userType];
}
