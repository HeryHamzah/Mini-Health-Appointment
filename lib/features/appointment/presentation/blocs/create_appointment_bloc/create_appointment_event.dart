part of 'create_appointment_bloc.dart';

sealed class CreateAppointmentEvent extends Equatable {
  const CreateAppointmentEvent();

  @override
  List<Object?> get props => [];
}

final class CreateAppointment extends CreateAppointmentEvent {
  final String patientName;
  final DateTime dateAndTime;
  final TherapistEntity therapist;
  final String? message;

  const CreateAppointment({
    required this.dateAndTime,
    required this.therapist,
    required this.patientName,
    this.message,
  });

  @override
  List<Object?> get props => [
        dateAndTime,
        therapist,
        patientName,
        message,
      ];
}
