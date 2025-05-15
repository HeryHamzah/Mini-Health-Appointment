import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';

import '../repositories/auth_repository.dart';

class CheckLoginStatusUseCase {
  final AuthRepository authRepository;

  CheckLoginStatusUseCase({required this.authRepository});

  Future<SessionEntity?> call() async {
    return authRepository.checkLoginStatus();
  }
}
