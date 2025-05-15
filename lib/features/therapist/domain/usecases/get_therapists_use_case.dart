import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';
import 'package:mini_health_appointment/features/therapist/domain/repositories/therapist_repository.dart';

class GetTherapistsUseCase {
  final TherapistRepository therapistRepository;

  GetTherapistsUseCase({required this.therapistRepository});

  Future<Either<AppException, List<TherapistEntity>>> call() =>
      therapistRepository.getTherapists();
}
