import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';

import '../entities/user_type_enum.dart';

abstract class AuthRepository {
  Future<Either<AppException, SessionEntity>> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<AppException, SessionEntity>> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  });

  Future<Either<AppException, Unit>> logout();

  Future<SessionEntity?> checkLoginStatus();
}
