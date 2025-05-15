import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../therapist/domain/entities/therapist_entity.dart';
import '../../domain/entities/appointment_status.dart';
import '../../domain/entities/patient_appointment_entity.dart';
import '../../domain/entities/therapist_appointment_entity.dart';

abstract class AppointmentDataSource {
  Future<Either<AppException, Unit>> createAppointment({
    required DateTime dateAndTime,
    required TherapistEntity therapist,
    required String patientName,
    String? message,
    required String userId,
  });

  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getUpcomingAppointments(
          {required int start, required int limit, required String userId});

  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getPastAppointments(
          {required int start, required int limit, required String userId});

  Future<Either<AppException, List<TherapistAppointmentEntity>>>
      getTherapistAppointments(
          {required int start, required int limit, required String userId});

  Future<Either<AppException, Unit>> updateAppointmentStatus(
      {required AppointmentStatus status, required String id});
}
