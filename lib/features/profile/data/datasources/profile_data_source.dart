import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileDataSource {
  Future<Either<AppException, ProfileEntity>> getProfile(String id);
}
