import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_entity.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';

class PatientAppointmentEntity extends AppointmentEntity {
  final TherapistEntity therapist;

  const PatientAppointmentEntity(
      {required super.appointmentId,
      required super.date,
      required super.appointmentStatus,
      required this.therapist});

  @override
  List<Object?> get props => super.props + [therapist];
}
