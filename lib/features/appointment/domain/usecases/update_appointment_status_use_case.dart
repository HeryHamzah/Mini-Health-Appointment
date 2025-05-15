import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/domain/repositories/appointment_repository.dart';

import '../entities/appointment_status.dart';

class UpdateAppointmentStatusUseCase {
  final AppointmentRepository appointmentRepository;

  UpdateAppointmentStatusUseCase({required this.appointmentRepository});

  Future<Either<AppException, Unit>> call(
          {required AppointmentStatus status, required String id}) =>
      appointmentRepository.updateAppointmentStatus(status: status, id: id);
}
