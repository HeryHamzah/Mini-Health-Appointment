import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/screens/patient_appointment_list_screen.dart';
import 'package:mini_health_appointment/features/home/presentation/screens/patient_home_screen.dart';
import 'package:mini_health_appointment/features/profile/presentation/screens/profile_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../profile/presentation/blocs/profile_bloc/profile_bloc.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  int _currentTabIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PatientHomeScreen(),
    PatientAppointmentListScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
