import 'package:mini_health_appointment/core/injection/injection.dart';
import 'package:mini_health_appointment/features/auth/data/datasources/local_session_data_source.dart';
import 'package:mini_health_appointment/features/profile/data/datasources/remote_profile_data_source.dart';
import 'package:mini_health_appointment/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mini_health_appointment/features/profile/domain/repositories/profile_repository.dart';
import 'package:mini_health_appointment/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:mini_health_appointment/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';

class ProfileInjectionImpl extends Injection {
  @override
  void inject() {
    //DATA

    di.registerLazySingleton<RemoteProfileDataSource>(
      () => RemoteProfileDataSource(),
    );
    di.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        localSessionDataSource: di<LocalSessionDataSource>(),
        remoteProfileDataSource: di<RemoteProfileDataSource>(),
      ),
    );

    //DOMAIN

    di.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(
        profileRepository: di<ProfileRepository>(),
      ),
    );

    //PRESENTATION
    di.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: di<GetProfileUseCase>(),
      ),
    );
  }
}
