part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {
  final SessionEntity session;

  const Authenticated({required this.session});

  @override
  List<Object> get props => [session];
}

final class Unauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final AppException exception;

  const AuthError({required this.exception});

  @override
  List<Object> get props => [exception];
}
