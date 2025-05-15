import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/patient_appointment_entity.dart';
import 'package:mini_health_appointment/features/appointment/domain/repositories/appointment_repository.dart';

class GetPastAppointmentsUseCase {
  final AppointmentRepository appointmentRepository;

  GetPastAppointmentsUseCase({required this.appointmentRepository});

  Future<Either<AppException, List<PatientAppointmentEntity>>> call(
          {required int start, required int limit}) =>
      appointmentRepository.getPastAppointments(start: start, limit: limit);
}
