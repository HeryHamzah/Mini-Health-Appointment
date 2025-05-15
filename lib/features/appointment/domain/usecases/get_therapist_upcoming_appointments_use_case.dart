import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/therapist_appointment_entity.dart';
import 'package:mini_health_appointment/features/appointment/domain/repositories/appointment_repository.dart';

class GetTherapistAppointmentsUseCase {
  final AppointmentRepository appointmentRepository;

  GetTherapistAppointmentsUseCase({required this.appointmentRepository});

  Future<Either<AppException, List<TherapistAppointmentEntity>>> call(
          {required int start, required int limit}) =>
      appointmentRepository.getTherapistAppointments(
          start: start, limit: limit);
}
