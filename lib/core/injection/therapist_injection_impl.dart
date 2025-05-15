import 'package:mini_health_appointment/core/injection/injection.dart';
import 'package:mini_health_appointment/features/therapist/data/datasources/remote_therapist_data_source.dart';
import 'package:mini_health_appointment/features/therapist/data/repositories/therapist_repository_impl.dart';
import 'package:mini_health_appointment/features/therapist/domain/repositories/therapist_repository.dart';
import 'package:mini_health_appointment/features/therapist/domain/usecases/get_therapists_use_case.dart';
import 'package:mini_health_appointment/features/therapist/presentation/blocs/get_therapist_bloc/get_therapists_bloc.dart';

class TherapistInjectionImpl extends Injection {
  @override
  void inject() {
    //DATA
    di.registerLazySingleton<RemoteTherapistDataSource>(
      () => RemoteTherapistDataSource(),
    );

    di.registerLazySingleton<TherapistRepository>(
      () => TherapistRepositoryImpl(
        remoteTherapistDataSource: di<RemoteTherapistDataSource>(),
      ),
    );

    //DOMAIN
    di.registerLazySingleton<GetTherapistsUseCase>(
      () => GetTherapistsUseCase(
        therapistRepository: di<TherapistRepository>(),
      ),
    );

    //PRESENTATION
    di.registerFactory<GetTherapistsBloc>(
      () => GetTherapistsBloc(
        getTherapistsUseCase: di<GetTherapistsUseCase>(),
      ),
    );
  }
}
