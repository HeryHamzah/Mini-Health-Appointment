import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';

import '../../../../core/utils/app_exception.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailAndPasswordUseCase {
  final AuthRepository authRepository;

  LoginWithEmailAndPasswordUseCase({required this.authRepository});

  Future<Either<AppException, SessionEntity>> call(
      {required String email, required String password}) {
    return authRepository.loginWithEmailAndPassword(
        email: email, password: password);
  }
}
