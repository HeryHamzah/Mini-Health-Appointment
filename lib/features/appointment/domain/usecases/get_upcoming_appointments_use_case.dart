import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/domain/repositories/appointment_repository.dart';

import '../entities/patient_appointment_entity.dart';

class GetUpcomingAppointmentsUseCase {
  final AppointmentRepository appointmentRepository;

  GetUpcomingAppointmentsUseCase({required this.appointmentRepository});

  Future<Either<AppException, List<PatientAppointmentEntity>>> call(
          {required int start, required int limit}) =>
      appointmentRepository.getUpcomingAppointments(start: start, limit: limit);
}
