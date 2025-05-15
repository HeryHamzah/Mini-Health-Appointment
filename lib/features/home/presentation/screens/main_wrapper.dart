import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';
import 'package:mini_health_appointment/features/home/presentation/screens/patient_main_screen.dart';

import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import 'therapist_main_screen.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case Authenticated():
            if (state.session.userType == UserType.patient) {
              return PatientMainScreen();
            } else if (state.session.userType == UserType.therapist) {
              return TherapistMainScreen();
            }
          default:
            return SizedBox();
        }
        return SizedBox();
      },
    );
  }
}
