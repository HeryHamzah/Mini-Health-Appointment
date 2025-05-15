part of 'get_therapists_bloc.dart';

sealed class GetTherapistsState extends Equatable {
  const GetTherapistsState();

  @override
  List<Object> get props => [];
}

final class GetTherapistsInitial extends GetTherapistsState {}

final class GetTherapistsLoading extends GetTherapistsState {}

final class GetTherapistsLoaded extends GetTherapistsState {
  final List<TherapistEntity> therapists;

  const GetTherapistsLoaded({required this.therapists});

  @override
  List<Object> get props => [therapists];
}

final class GetTherapistsFailed extends GetTherapistsState {
  final AppException exception;

  const GetTherapistsFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
