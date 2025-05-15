import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';

abstract class TherapistRepository {
  Future<Either<AppException, List<TherapistEntity>>> getTherapists();
}
