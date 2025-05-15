import 'package:mini_health_appointment/core/injection/injection.dart';
import 'package:mini_health_appointment/features/appointment/data/datasources/remote_appointment_data_source.dart';
import 'package:mini_health_appointment/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/create_appointment_use_case.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/get_past_appointments_use_case.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/get_therapist_upcoming_appointments_use_case.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/get_upcoming_appointments_use_case.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/update_appointment_status_use_case.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/create_appointment_bloc/create_appointment_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_past_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_upcoming_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_therapist_appointments_bloc/get_therapist_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/update_appointment_status_bloc.dart/update_appointment_status_bloc.dart';
import 'package:mini_health_appointment/features/auth/data/datasources/local_session_data_source.dart';

import '../../features/appointment/domain/repositories/appointment_repository.dart';

class AppointmentInjectionImpl extends Injection {
  @override
  void inject() {
    //DATA
    di.registerLazySingleton<RemoteAppointmentDataSource>(
      () => RemoteAppointmentDataSource(),
    );

    di.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(
        localSessionDataSource: di<LocalSessionDataSource>(),
        remoteAppointmentDataSource: di<RemoteAppointmentDataSource>(),
      ),
    );

    //DOMAIN
    di.registerLazySingleton<CreateAppointmentUseCase>(
      () => CreateAppointmentUseCase(
        appointmentRepository: di<AppointmentRepository>(),
      ),
    );

    di.registerLazySingleton<GetPastAppointmentsUseCase>(
      () => GetPastAppointmentsUseCase(
        appointmentRepository: di<AppointmentRepository>(),
      ),
    );

    di.registerLazySingleton<GetUpcomingAppointmentsUseCase>(
      () => GetUpcomingAppointmentsUseCase(
        appointmentRepository: di<AppointmentRepository>(),
      ),
    );

    di.registerLazySingleton<GetTherapistAppointmentsUseCase>(
      () => GetTherapistAppointmentsUseCase(
        appointmentRepository: di<AppointmentRepository>(),
      ),
    );

    di.registerLazySingleton<UpdateAppointmentStatusUseCase>(
      () => UpdateAppointmentStatusUseCase(
        appointmentRepository: di<AppointmentRepository>(),
      ),
    );

    //PRESENTATION
    di.registerFactory<CreateAppointmentBloc>(
      () => CreateAppointmentBloc(
        createAppointmentUseCase: di<CreateAppointmentUseCase>(),
      ),
    );

    di.registerFactory<GetPatientPastAppointmentsBloc>(
      () => GetPatientPastAppointmentsBloc(
        getPastAppointmentsUseCase: di<GetPastAppointmentsUseCase>(),
      ),
    );

    di.registerFactory<GetPatientUpcomingAppointmentsBloc>(
      () => GetPatientUpcomingAppointmentsBloc(
        getUpcomingAppointmentsUseCase: di<GetUpcomingAppointmentsUseCase>(),
      ),
    );

    di.registerFactory<GetTherapistAppointmentsBloc>(
      () => GetTherapistAppointmentsBloc(
        getTherapistAppointmentsUseCase: di<GetTherapistAppointmentsUseCase>(),
      ),
    );

    di.registerFactory<UpdateAppointmentStatusBloc>(
      () => UpdateAppointmentStatusBloc(
        updateAppointmentStatusUseCase: di<UpdateAppointmentStatusUseCase>(),
      ),
    );
  }
}
