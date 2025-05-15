import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/therapist/data/datasources/therapist_data_source.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';
import 'package:mini_health_appointment/features/therapist/domain/repositories/therapist_repository.dart';

class TherapistRepositoryImpl extends TherapistRepository {
  final TherapistDataSource remoteTherapistDataSource;

  TherapistRepositoryImpl({required this.remoteTherapistDataSource});

  @override
  Future<Either<AppException, List<TherapistEntity>>> getTherapists() {
    return remoteTherapistDataSource.getTherapists();
  }
}
