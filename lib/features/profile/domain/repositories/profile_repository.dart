import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_exception.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<AppException, ProfileEntity>> getProfile();
}
