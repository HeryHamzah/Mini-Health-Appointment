import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/shared/full_screen_loading_widget.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_appointments_event.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_therapist_appointments_bloc/get_therapist_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/update_appointment_status_bloc.dart/update_appointment_status_bloc.dart';
import 'package:mini_health_appointment/features/home/presentation/screens/therapist_home_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../appointment/presentation/screens/therapist_appointment_list_screen.dart';
import '../../../profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class TherapistMainScreen extends StatefulWidget {
  const TherapistMainScreen({super.key});

  @override
  State<TherapistMainScreen> createState() => _TherapistMainScreenState();
}

class _TherapistMainScreenState extends State<TherapistMainScreen> {
  int _currentTabIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TherapistHomeScreen(),
    TherapistAppointmentListScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAppointmentStatusBloc,
        UpdateAppointmentStatusState>(
      listener: (context, state) {
        if (state is UpdateAppointmentStatusSuccessful) {
          context.read<GetTherapistAppointmentsBloc>().add(GetMyAppointments());
        } else if (state is UpdateAppointmentStatusFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.exception.message)));
        }
      },
      child: Stack(
        children: [
          Scaffold(
            body: IndexedStack(
              index: _currentTabIndex,
              children: _widgetOptions,
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentTabIndex,
                onTap: (value) {
                  setState(() {
                    _currentTabIndex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      activeIcon: PhosphorIcon(
                        PhosphorIconsFill.house,
                      ),
                      icon: PhosphorIcon(PhosphorIconsLight.house),
                      label: ""),
                  BottomNavigationBarItem(
                      activeIcon: PhosphorIcon(
                        PhosphorIconsFill.listBullets,
                      ),
                      icon: PhosphorIcon(PhosphorIconsLight.listBullets),
                      label: ""),
                  BottomNavigationBarItem(
                      activeIcon: PhosphorIcon(
                        PhosphorIconsFill.userCircle,
                      ),
                      icon: PhosphorIcon(PhosphorIconsLight.userCircle),
                      label: ""),
                ]),
          ),
          if (context.watch<UpdateAppointmentStatusBloc>().state
              is UpdateAppointmentStatusLoading)
            FullScreenLoadingWidget()
        ],
      ),
    );
  }
}
