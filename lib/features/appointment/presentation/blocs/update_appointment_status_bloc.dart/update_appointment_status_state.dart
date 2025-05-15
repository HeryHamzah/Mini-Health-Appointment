part of 'update_appointment_status_bloc.dart';

sealed class UpdateAppointmentStatusState extends Equatable {
  const UpdateAppointmentStatusState();

  @override
  List<Object> get props => [];
}

final class UpdateAppointmentStatusInitial
    extends UpdateAppointmentStatusState {}

final class UpdateAppointmentStatusLoading
    extends UpdateAppointmentStatusState {}

final class UpdateAppointmentStatusSuccessful
    extends UpdateAppointmentStatusState {}

final class UpdateAppointmentStatusFailed extends UpdateAppointmentStatusState {
  final AppException exception;

  const UpdateAppointmentStatusFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
