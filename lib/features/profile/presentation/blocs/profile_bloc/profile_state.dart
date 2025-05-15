part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

final class ProfileFailed extends ProfileState {
  final AppException exception;

  const ProfileFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
