import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_entity.dart';

class TherapistAppointmentEntity extends AppointmentEntity {
  final String patientName;
  final String? message;

  const TherapistAppointmentEntity(
      {required super.appointmentId,
      required super.date,
      required super.appointmentStatus,
      required this.patientName,
      this.message});

  @override
  List<Object?> get props => super.props + [patientName, message];
}
