import 'package:equatable/equatable.dart';

import '../../../../../core/utils/app_exception.dart';
import '../../../domain/entities/patient_appointment_entity.dart';

sealed class GetPatientAppointmentsState extends Equatable {
  const GetPatientAppointmentsState();

  @override
  List<Object> get props => [];
}

final class GetPatientAppointmentsInitial extends GetPatientAppointmentsState {}

final class GetPatientAppointmentsLoading extends GetPatientAppointmentsState {}

final class GetPatientAppointmentsLoaded extends GetPatientAppointmentsState {
  final List<PatientAppointmentEntity> myAppointments;
  final bool hasReachMax;

  const GetPatientAppointmentsLoaded({
    required this.myAppointments,
    required this.hasReachMax,
  });

  @override
  List<Object> get props => [myAppointments, hasReachMax];
}

final class GetPatientAppointmentsFailed extends GetPatientAppointmentsState {
  final AppException exception;

  const GetPatientAppointmentsFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
