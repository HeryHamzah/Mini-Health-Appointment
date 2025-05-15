import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/entities/therapist_entity.dart';

abstract class TherapistDataSource {
  Future<Either<AppException, List<TherapistEntity>>> getTherapists();
}
