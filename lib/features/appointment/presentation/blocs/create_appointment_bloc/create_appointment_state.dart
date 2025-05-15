part of 'create_appointment_bloc.dart';

sealed class CreateAppointmentState extends Equatable {
  const CreateAppointmentState();

  @override
  List<Object> get props => [];
}

final class CreateAppointmentInitial extends CreateAppointmentState {}

final class CreateAppointmentLoading extends CreateAppointmentState {}

final class CreateAppointmentSuccessful extends CreateAppointmentState {}

final class CreateAppointmentFailed extends CreateAppointmentState {
  final AppException exception;

  const CreateAppointmentFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
