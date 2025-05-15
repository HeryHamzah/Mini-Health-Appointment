import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_exception.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  Future<Either<AppException, Unit>> call() {
    return authRepository.logout();
  }
}
