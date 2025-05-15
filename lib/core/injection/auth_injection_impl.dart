import 'package:mini_health_appointment/features/auth/domain/usecases/check_login_status_use_case.dart';
import 'package:mini_health_appointment/features/auth/domain/usecases/register_use_case.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/logout/logout_bloc.dart';

import '../../features/auth/data/datasources/local_session_data_source.dart';
import '../../features/auth/data/datasources/remote_auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_with_email_and_password_use_case.dart';
import '../../features/auth/domain/usecases/logout_use_case.dart';
import 'injection.dart';

class AuthInjectionImpl extends Injection {
  @override
  void inject() {
    //DATA
    di.registerLazySingleton<LocalSessionDataSource>(
      () => LocalSessionDataSource(),
    );

    di.registerLazySingleton<RemoteAuthDataSource>(
      () => RemoteAuthDataSource(),
    );

    di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        localSessionDataSource: di<LocalSessionDataSource>(),
        remoteAuthDataSource: di<RemoteAuthDataSource>(),
      ),
    );

    //DOMAIN
    di.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(
        authRepository: di<AuthRepository>(),
      ),
    );

    di.registerLazySingleton<CheckLoginStatusUseCase>(
      () => CheckLoginStatusUseCase(
        authRepository: di<AuthRepository>(),
      ),
    );

    di.registerLazySingleton<LoginWithEmailAndPasswordUseCase>(
      () => LoginWithEmailAndPasswordUseCase(
        authRepository: di<AuthRepository>(),
      ),
    );

    di.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        authRepository: di<AuthRepository>(),
      ),
    );

    //PRESENTATION
    di.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginWithEmailAndPasswordUseCase:
            di<LoginWithEmailAndPasswordUseCase>(),
        checkSessionUseCase: di<CheckLoginStatusUseCase>(),
        registerUseCase: di<RegisterUseCase>(),
      ),
    );

    di.registerFactory<LogoutBloc>(
      () => LogoutBloc(
        logoutUseCase: di<LogoutUseCase>(),
      ),
    );
  }
}
