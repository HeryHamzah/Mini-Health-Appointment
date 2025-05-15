import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';
import 'package:mini_health_appointment/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user_type_enum.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<AppException, SessionEntity>> call({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) {
    return authRepository.register(
      email: email,
      password: password,
      name: name,
      userType: userType,
    );
  }
}
