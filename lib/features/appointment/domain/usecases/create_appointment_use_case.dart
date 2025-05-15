import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';

class CreateAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  CreateAppointmentUseCase({required this.appointmentRepository});

  Future<Either<AppException, Unit>> call({
    required DateTime dateAndTime,
    required TherapistEntity therapist,
    required String patientName,
    String? message,
  }) =>
      appointmentRepository.createAppointment(
        dateAndTime: dateAndTime,
        patientName: patientName,
        therapist: therapist,
        message: message,
      );
}
