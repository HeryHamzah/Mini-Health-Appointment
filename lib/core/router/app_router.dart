import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/features/appointment/presentation/screens/create_appointment_screen.dart';
import 'package:mini_health_appointment/features/home/presentation/screens/main_wrapper.dart';

import '../../features/appointment/presentation/blocs/create_appointment_form_bloc/create_appointment_form_bloc.dart';
import '../../features/auth/presentation/screens/landing_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'route_app.dart';

final GoRouter appRouter = GoRouter(
  routerNeglect: true,
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      name: RouteName.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: "/landing",
      name: RouteName.landing,
      builder: (context, state) {
        return const LandingScreen();
      },
      routes: [
        GoRoute(
          path: "register",
          name: RouteName.register,
          builder: (context, state) {
            return const RegisterScreen();
          },
        ),
        GoRoute(
          path: "login",
          name: RouteName.login,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: "/main",
      name: RouteName.main,
      builder: (context, state) {
        return const MainWrapper();
      },
      routes: [
        GoRoute(
          path: "createAppointment",
          name: RouteName.createAppointment,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => CreateAppointmentFormBloc(),
              child: CreateAppointmentScreen(),
            );
          },
        )
      ],
    ),
  ],
);
