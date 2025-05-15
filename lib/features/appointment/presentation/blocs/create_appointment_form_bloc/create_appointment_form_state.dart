part of 'create_appointment_form_bloc.dart';

class CreateAppointmentFormState extends Equatable {
  final String? patientName;
  final String? message;
  final TherapistEntity? selectedTherapist;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  const CreateAppointmentFormState({
    this.patientName,
    this.message,
    this.selectedTherapist,
    this.selectedDate,
    this.selectedTime,
  });

  CreateAppointmentFormState copyWith({
    String? patientName,
    String? message,
    TherapistEntity? selectedTherapist,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  }) {
    return CreateAppointmentFormState(
      patientName: patientName ?? this.patientName,
      message: message ?? this.message,
      selectedTherapist: selectedTherapist ?? this.selectedTherapist,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object?> get props =>
      [patientName, message, selectedTherapist, selectedDate, selectedTime];
}
