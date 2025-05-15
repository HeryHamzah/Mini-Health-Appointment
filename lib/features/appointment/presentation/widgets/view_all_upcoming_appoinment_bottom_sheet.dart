import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_appointments_state.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_upcoming_appointments_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/widgets/patient_appointment_card.dart';

import '../../../../core/translations/locale_keys.g.dart';

class ViewAllUpcomingAppointmentBottomSheet extends StatelessWidget {
  final ScrollController controller;
  const ViewAllUpcomingAppointmentBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPatientUpcomingAppointmentsBloc,
        GetPatientAppointmentsState>(
      builder: (context, pState) {
        var state = pState as GetPatientAppointmentsLoaded;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.upcoming_appointment.tr(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < state.myAppointments.length) {
                      var appointment = state.myAppointments[index];

                      return PatientAppointmentCard(
                        appointment: appointment,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  itemCount: state.hasReachMax
                      ? state.myAppointments.length
                      : state.myAppointments.length + 1),
            )
          ],
        );
      },
    );
  }
}
