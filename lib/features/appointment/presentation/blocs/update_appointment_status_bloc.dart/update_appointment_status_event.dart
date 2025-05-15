part of 'update_appointment_status_bloc.dart';

sealed class UpdateAppointmentStatusEvent extends Equatable {
  const UpdateAppointmentStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateAppointmentStatus extends UpdateAppointmentStatusEvent {
  final AppointmentStatus appointmentStatus;
  final String appointmentId;

  const UpdateAppointmentStatus(
      {required this.appointmentStatus, required this.appointmentId});

  @override
  List<Object> get props => [appointmentStatus, appointmentId];
}
