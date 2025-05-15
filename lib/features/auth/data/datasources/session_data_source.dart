import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';

abstract class SessionDataSource {
  Future<void> saveSession(SessionEntity session);
  Future<SessionEntity?> getSession();
  Future<void> clearSession();
}
