import 'package:equatable/equatable.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/therapist_appointment_entity.dart';

import '../../../../../core/utils/app_exception.dart';

sealed class GetTherapistAppointmentsState extends Equatable {
  const GetTherapistAppointmentsState();

  @override
  List<Object> get props => [];
}

final class GetTherapistAppointmentsInitial
    extends GetTherapistAppointmentsState {}

final class GetTherapistAppointmentsLoading
    extends GetTherapistAppointmentsState {}

final class GetTherapistAppointmentsLoaded
    extends GetTherapistAppointmentsState {
  final List<TherapistAppointmentEntity> myAppointments;
  final bool hasReachMax;

  const GetTherapistAppointmentsLoaded({
    required this.myAppointments,
    required this.hasReachMax,
  });

  @override
  List<Object> get props => [myAppointments, hasReachMax];
}

final class GetTherapistAppointmentsFailed
    extends GetTherapistAppointmentsState {
  final AppException exception;

  const GetTherapistAppointmentsFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
