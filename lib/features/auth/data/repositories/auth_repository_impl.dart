import 'package:mini_health_appointment/features/auth/domain/entities/session_entity.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/auth_data_source.dart';
import '../datasources/session_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource remoteAuthDataSource;
  final SessionDataSource localSessionDataSource;

  AuthRepositoryImpl(
      {required this.remoteAuthDataSource,
      required this.localSessionDataSource});

  @override
  Future<Either<AppException, SessionEntity>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    final result = await remoteAuthDataSource.login(
      email: email,
      password: password,
    );

    return await result.fold(
      (exception) async => left(exception),
      (session) async {
        await localSessionDataSource.saveSession(session);
        return right(session);
      },
    );
  }

  @override
  Future<Either<AppException, SessionEntity>> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) async {
    final result = await remoteAuthDataSource.register(
      email: email,
      password: password,
      name: name,
      userType: userType,
    );

    return await result.fold(
      (exception) {
        return left(exception);
      },
      (session) async {
        await localSessionDataSource.saveSession(session);
        return right(session);
      },
    );
  }

  @override
  Future<Either<AppException, Unit>> logout() async {
    try {
      await localSessionDataSource.clearSession();

      return right(unit);
    } on AppException catch (e) {
      return left(e);
    }
  }

  @override
  Future<SessionEntity?> checkLoginStatus() async {
    final session = await localSessionDataSource.getSession();

    return session;
  }
}
