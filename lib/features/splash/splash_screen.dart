import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/core/router/route_app.dart';
import 'package:mini_health_appointment/core/shared/app_icon_with_label_widget.dart';
import 'package:mini_health_appointment/features/auth/presentation/blocs/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckLoginStatusRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.goNamed(RouteName.main);
        } else if (state is Unauthenticated) {
          context.goNamed(RouteName.landing);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: AppIconWithLabelWidget(
            fillColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
