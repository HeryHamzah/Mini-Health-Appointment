import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/data/datasources/appointment_data_source.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/patient_appointment_entity.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/therapist_appointment_entity.dart';
import 'package:mini_health_appointment/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:mini_health_appointment/features/auth/data/datasources/local_session_data_source.dart';

import '../../../therapist/domain/entities/therapist_entity.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  final LocalSessionDataSource localSessionDataSource;
  final AppointmentDataSource remoteAppointmentDataSource;

  AppointmentRepositoryImpl(
      {required this.remoteAppointmentDataSource,
      required this.localSessionDataSource});

  @override
  Future<Either<AppException, Unit>> createAppointment({
    required DateTime dateAndTime,
    required TherapistEntity therapist,
    required String patientName,
    String? message,
  }) async {
    try {
      final session = await localSessionDataSource.getSession();

      return remoteAppointmentDataSource.createAppointment(
        dateAndTime: dateAndTime,
        patientName: patientName,
        therapist: therapist,
        message: message,
        userId: session!.token,
      );
    } catch (e) {
      return Left(GeneralException(message: "No session"));
    }
  }

  @override
  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getUpcomingAppointments({required int start, required int limit}) async {
    try {
      final session = await localSessionDataSource.getSession();

      return remoteAppointmentDataSource.getUpcomingAppointments(
          start: start, limit: limit, userId: session!.token);
    } catch (e) {
      return Left(GeneralException(message: "No session"));
    }
  }

  @override
  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getPastAppointments({required int start, required int limit}) async {
    try {
      final session = await localSessionDataSource.getSession();

      return remoteAppointmentDataSource.getPastAppointments(
          start: start, limit: limit, userId: session!.token);
    } catch (e) {
      return Left(GeneralException(message: "No session"));
    }
  }

  @override
  Future<Either<AppException, List<TherapistAppointmentEntity>>>
      getTherapistAppointments({required int start, required int limit}) async {
    try {
      final session = await localSessionDataSource.getSession();

      return remoteAppointmentDataSource.getTherapistAppointments(
          start: start, limit: limit, userId: session!.token);
    } catch (e) {
      return Left(GeneralException(message: "No session"));
    }
  }

  @override
  Future<Either<AppException, Unit>> updateAppointmentStatus(
      {required AppointmentStatus status, required String id}) {
    return remoteAppointmentDataSource.updateAppointmentStatus(
        status: status, id: id);
  }
}
