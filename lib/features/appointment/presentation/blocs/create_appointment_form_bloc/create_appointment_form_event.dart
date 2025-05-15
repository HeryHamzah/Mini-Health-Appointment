part of 'create_appointment_form_bloc.dart';

sealed class CreateAppointmentFormEvent extends Equatable {
  const CreateAppointmentFormEvent();

  @override
  List<Object?> get props => [];
}

class ChangeAppointmentValue extends CreateAppointmentFormEvent {
  final String? patientName;
  final String? message;
  final TherapistEntity? selectedTherapist;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const ChangeAppointmentValue({
    this.patientName,
    this.message,
    this.selectedTherapist,
    this.selectedDate,
    this.selectedTime,
  });

  @override
  List<Object?> get props =>
      [patientName, message, selectedTherapist, selectedDate, selectedTime];
}
