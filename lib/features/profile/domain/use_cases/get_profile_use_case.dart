import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_exception.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository profileRepository;

  GetProfileUseCase({required this.profileRepository});

  Future<Either<AppException, ProfileEntity>> call() {
    return profileRepository.getProfile();
  }
}
