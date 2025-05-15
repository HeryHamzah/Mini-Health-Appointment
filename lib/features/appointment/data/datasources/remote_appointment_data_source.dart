import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/features/appointment/data/datasources/appointment_data_source.dart';
import 'package:mini_health_appointment/features/appointment/data/models/remote_appointment_model.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/therapist_appointment_entity.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/entities/patient_appointment_entity.dart';

class RemoteAppointmentDataSource extends AppointmentDataSource {
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  @override
  Future<Either<AppException, Unit>> createAppointment({
    required DateTime dateAndTime,
    required TherapistEntity therapist,
    required String patientName,
    String? message,
    required String userId,
  }) async {
    try {
      final uuid = Uuid().v4();

      await appointments.doc(uuid).set({
        'appointment_id': uuid,
        'user_id': userId,
        'patient_name': patientName,
        'date_time': dateAndTime.millisecondsSinceEpoch,
        'therapist': {
          'id': therapist.id,
          'email': therapist.email,
          'image_path': therapist.profilePicPath,
          'user_type': UserType.therapist.name,
          'name': therapist.name,
        },
        'message': message,
        'status': AppointmentStatus.isNew.name,
      });

      return Right(unit);
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getUpcomingAppointments(
          {required int start,
          required int limit,
          required String userId}) async {
    try {
      QuerySnapshot querySnapshot =
          await appointments.where("user_id", isEqualTo: userId).get();

      final data = querySnapshot.docs;

      final appoinmentsModel = data
          .map(
            (e) => RemoteAppointmentModel.fromJson(
                e.data() as Map<String, dynamic>),
          )
          .toList();

      final appointmentsEntity = appoinmentsModel
          .map(
            (e) => e.patientAppointmentEntity(),
          )
          .toList();

      final upcomingAppointments = appointmentsEntity
          .where((element) => element.date.isAfter(DateTime.now()))
          .toList();

      upcomingAppointments.sort(
        (a, b) => a.date.compareTo(b.date),
      );

      return Right(upcomingAppointments);
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<PatientAppointmentEntity>>>
      getPastAppointments(
          {required int start,
          required int limit,
          required String userId}) async {
    try {
      QuerySnapshot querySnapshot =
          await appointments.where("user_id", isEqualTo: userId).get();

      final data = querySnapshot.docs;

      final appoinmentsModel = data
          .map(
            (e) => RemoteAppointmentModel.fromJson(
                e.data() as Map<String, dynamic>),
          )
          .toList();

      final appointmentsEntity = appoinmentsModel
          .map(
            (e) => e.patientAppointmentEntity(),
          )
          .toList();

      final pastAppointments = appointmentsEntity
          .where((element) => element.date.isBefore(DateTime.now()))
          .toList();

      pastAppointments.sort(
        (a, b) => a.date.compareTo(b.date),
      );

      return Right(pastAppointments);
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }

  @override
  Future<Either<AppException, List<TherapistAppointmentEntity>>>
      getTherapistAppointments(
          {required int start,
          required int limit,
          required String userId}) async {
    try {
      QuerySnapshot querySnapshot =
          await appointments.where("therapist.id", isEqualTo: userId).get();

      final data = querySnapshot.docs;

      final appoinmentsModel = data
          .map(
            (e) => RemoteAppointmentModel.fromJson(
                e.data() as Map<String, dynamic>),
          )
          .toList();

      final appointmentsEntity = appoinmentsModel
          .map(
            (e) => e.therapistAppointmentEntity(),
          )
          .toList();

      appointmentsEntity.sort(
        (a, b) => a.date.compareTo(b.date),
      );

      return Right(appointmentsEntity);
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }

  @override
  Future<Either<AppException, Unit>> updateAppointmentStatus(
      {required AppointmentStatus status, required String id}) async {
    try {
      await appointments.doc(id).set({
        'status': status.name,
      }, SetOptions(merge: true));

      return Right(unit);
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }
}
