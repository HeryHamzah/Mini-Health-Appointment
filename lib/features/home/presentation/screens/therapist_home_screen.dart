import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';

import '../../../appointment/presentation/blocs/get_appointments_event.dart';
import '../../../appointment/presentation/blocs/get_therapist_appointments_bloc/get_therapist_appointments_bloc.dart';
import '../../../appointment/presentation/blocs/get_therapist_appointments_bloc/get_therapist_appointments_state.dart';
import '../../../appointment/presentation/blocs/update_appointment_status_bloc.dart/update_appointment_status_bloc.dart';
import '../../../appointment/presentation/widgets/appointment_card_shimmer.dart';
import '../../../appointment/presentation/widgets/therapist_appointment_card.dart';
import '../../../profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/empty_widget.dart';

class TherapistHomeScreen extends StatefulWidget {
  const TherapistHomeScreen({super.key});

  @override
  State<TherapistHomeScreen> createState() => _TherapistHomeScreenState();
}

class _TherapistHomeScreenState extends State<TherapistHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetTherapistAppointmentsBloc>().add(GetMyAppointments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                SizedBox(
                  height: 40,
                ),
                BlocSelector<ProfileBloc, ProfileState, String?>(
                  selector: (state) {
                    return state is ProfileLoaded
                        ? state.profile.fullname
                        : null;
                  },
                  builder: (context, state) {
                    return Text(
                      state != null ? "Welcome, \n$state!" : "Hello!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    );
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  LocaleKeys.upcoming_appointment.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 12,
                ),
                BlocBuilder<GetTherapistAppointmentsBloc,
                    GetTherapistAppointmentsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        switch (state) {
                          GetTherapistAppointmentsLoading() =>
                            ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemCount: 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AppointmentCardShimmer();
                              },
                            ),
                          GetTherapistAppointmentsLoaded(
                            :final myAppointments
                          ) =>
                            ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemCount: myAppointments.length > 1
                                  ? 1
                                  : myAppointments.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final appointment = myAppointments[index];
                                return TherapistAppointmentCard(
                                  appointment: appointment,
                                  onSelected: (p0) {
                                    if (p0 != appointment.appointmentStatus) {
                                      context
                                          .read<UpdateAppointmentStatusBloc>()
                                          .add(
                                            UpdateAppointmentStatus(
                                                appointmentStatus: p0,
                                                appointmentId:
                                                    appointment.appointmentId),
                                          );
                                    }
                                  },
                                );
                              },
                            ),
                          GetTherapistAppointmentsFailed(:final exception) =>
                            CustomErrorWidget(
                              exception: exception,
                              onTap: () {
                                context
                                    .read<GetTherapistAppointmentsBloc>()
                                    .add(GetMyAppointments());
                              },
                            ),
                          GetTherapistAppointmentsInitial() => EmptyWidget(),
                        }
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
