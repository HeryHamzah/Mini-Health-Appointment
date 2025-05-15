import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';

import 'session_data_source.dart';

class LocalSessionDataSource extends SessionDataSource {
  final _secureStorage = FlutterSecureStorage();
  static const _tokenKey = 'token_token';
  static const _userTypeKey = 'user_type_token';

  @override
  Future<void> clearSession() async {
    try {
      return await _secureStorage.deleteAll();
    } catch (e) {
      throw GeneralException(message: "Error clear session");
    }
  }

  @override
  Future<void> saveSession(SessionEntity session) async {
    try {
      await Future.wait([
        _secureStorage.write(key: _tokenKey, value: session.token),
        _secureStorage.write(key: _userTypeKey, value: session.userType.name)
      ]);
    } catch (e) {
      throw GeneralException(message: "Error save session");
    }
  }

  @override
  Future<SessionEntity?> getSession() async {
    String? token = await _secureStorage.read(key: _tokenKey);
    String? userType = await _secureStorage.read(key: _userTypeKey);

    if (token != null && userType != null) {
      return SessionEntity(
          token: token,
          userType: UserType.values.singleWhere(
            (element) => element.name == userType,
          ));
    }

    return null;
  }
}
