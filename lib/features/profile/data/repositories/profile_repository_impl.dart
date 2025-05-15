import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/features/auth/data/datasources/local_session_data_source.dart';
import 'package:mini_health_appointment/features/profile/data/datasources/profile_data_source.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataSource remoteProfileDataSource;
  final LocalSessionDataSource localSessionDataSource;

  ProfileRepositoryImpl(
      {required this.remoteProfileDataSource,
      required this.localSessionDataSource});

  @override
  Future<Either<AppException, ProfileEntity>> getProfile() async {
    try {
      final session = await localSessionDataSource.getSession();
      return remoteProfileDataSource.getProfile(session!.token);
    } catch (e) {
      return Left(GeneralException(message: "No session"));
    }
  }
}
