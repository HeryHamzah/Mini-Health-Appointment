import 'package:equatable/equatable.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';

abstract class AppointmentEntity extends Equatable {
  final String appointmentId;
  final DateTime date;
  final AppointmentStatus appointmentStatus;

  const AppointmentEntity(
      {required this.appointmentId,
      required this.date,
      required this.appointmentStatus});

  @override
  List<Object?> get props => [appointmentId, date, appointmentStatus];
}
