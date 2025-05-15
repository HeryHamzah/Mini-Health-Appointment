part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccessful extends LogoutState {}

final class LogoutFailed extends LogoutState {
  final AppException exception;

  const LogoutFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
