import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';

import '../../../therapist/domain/entities/therapist_entity.dart';
import '../entities/appointment_status.dart';
import '../entities/patient_appointment_entity.dart';
import '../entities/therapist_appointment_entity.dart';

abstract class AppointmentRepository {
  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getUpcomingAppointments({required int start, required int limit});
  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getPastAppointments({required int start, required int limit});

  Future<Either<AppException, Unit>> createAppointment({
    required DateTime dateAndTime,
    required TherapistEntity therapist,
    required String patientName,
    String? message,
  });

  Future<Either<AppException, List<TherapistAppointmentEntity>>>
      getTherapistAppointments({required int start, required int limit});

  Future<Either<AppException, Unit>> updateAppointmentStatus(
      {required AppointmentStatus status, required String id});
}
