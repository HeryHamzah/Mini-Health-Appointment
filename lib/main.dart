import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mini_health_appointment/core/injection/appointment_injection_impl.dart';
import 'package:mini_health_appointment/core/injection/profile_injection_impl.dart';
import 'package:mini_health_appointment/core/injection/therapist_injection_impl.dart';
import 'package:mini_health_appointment/core/router/app_router.dart';
import 'package:mini_health_appointment/core/theme/theme_data.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/create_appointment_bloc/create_appointment_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_upcoming_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_therapist_appointments_bloc/get_therapist_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/update_appointment_status_bloc.dart/update_appointment_status_bloc.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/logout/logout_bloc.dart';
import 'package:mini_health_appointment/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:mini_health_appointment/features/therapist/presentation/blocs/get_therapist_bloc/get_therapists_bloc.dart';

import 'core/extensions/app_info_ext.dart';
import 'core/injection/auth_injection_impl.dart';
import 'features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_past_appointments_bloc.dart';
import 'firebase_options.dart';

final di = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await BuildContextExtension.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //INJECTOR
  AuthInjectionImpl().inject();
  ProfileInjectionImpl().inject();
  AppointmentInjectionImpl().inject();
  TherapistInjectionImpl().inject();

  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => di<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => di<CreateAppointmentBloc>(),
        ),
        BlocProvider(
          create: (context) => di<GetPatientUpcomingAppointmentsBloc>(),
        ),
        BlocProvider(
          create: (context) => di<GetPatientPastAppointmentsBloc>(),
        ),
        BlocProvider(
          create: (context) => di<GetTherapistsBloc>()..add(GetTherapists()),
        ),
        BlocProvider(
          create: (context) => di<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => di<LogoutBloc>(),
        ),
        BlocProvider(
          create: (context) => di<GetTherapistAppointmentsBloc>(),
        ),
        BlocProvider(
          create: (context) => di<UpdateAppointmentStatusBloc>(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Physiomobile',
        theme: AppTheme.themeData(context, Brightness.light),
        darkTheme: AppTheme.themeData(context, Brightness.dark),
      ),
    );
  }
}
