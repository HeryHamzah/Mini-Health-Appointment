import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/core/router/route_app.dart';
import 'package:mini_health_appointment/core/theme/text_style_ext.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_appointments_event.dart';
import 'package:mini_health_appointment/features/appointment/presentation/widgets/patient_appointment_card.dart';
import 'package:mini_health_appointment/features/appointment/presentation/widgets/view_all_upcoming_appoinment_bottom_sheet.dart';
import 'package:mini_health_appointment/features/home/presentation/widgets/empty_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_appointments_state.dart';
import '../../../appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_past_appointments_bloc.dart';
import '../../../appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_upcoming_appointments_bloc.dart';
import '../../../appointment/presentation/widgets/appointment_card_shimmer.dart';
import '../../../profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import '../widgets/custom_error_widget.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  final ScrollController _upcomingAppointmentsController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<GetPatientUpcomingAppointmentsBloc>().add(GetMyAppointments());
    context.read<GetPatientPastAppointmentsBloc>().add(GetMyAppointments());

    _upcomingAppointmentsController.addListener(() {
      if (_upcomingAppointmentsController.position.maxScrollExtent ==
          _upcomingAppointmentsController.offset) {
        if (!(context.read<GetPatientUpcomingAppointmentsBloc>().state
                as GetPatientAppointmentsLoaded)
            .hasReachMax) {
          context
              .read<GetPatientUpcomingAppointmentsBloc>()
              .add(GetMoreMyAppointments());
        }
      }
    });
  }

  @override
  void dispose() {
    _upcomingAppointmentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      BlocSelector<ProfileBloc, ProfileState, String?>(
                        selector: (state) {
                          return state is ProfileLoaded
                              ? state.profile.fullname
                              : null;
                        },
                        builder: (context, state) {
                          return Text(
                            state != null ? "Hello, $state!" : "Hello!",
                            style: Theme.of(context).textTheme.headlineSmall,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(RouteName.createAppointment);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Row(
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 4,
                                    children: [
                                      Text(
                                        LocaleKeys.book_an_appointment.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.onPrimary(context),
                                      ),
                                      Text(
                                        LocaleKeys.book_an_appointment_desc
                                            .tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.onPrimary(context),
                                      )
                                    ],
                                  ),
                                ),
                                PhosphorIcon(
                                  PhosphorIconsDuotone.calendarDots,
                                  size: 60,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  duotoneSecondaryColor:
                                      Theme.of(context).colorScheme.scrim,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<GetPatientUpcomingAppointmentsBloc,
                          GetPatientAppointmentsState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.upcoming_appointment.tr(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  if (state is GetPatientAppointmentsLoaded &&
                                      state.myAppointments.length > 2)
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          useSafeArea: true,
                                          isScrollControlled: true,
                                          showDragHandle: true,
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: ViewAllUpcomingAppointmentBottomSheet(
                                                    controller:
                                                        _upcomingAppointmentsController),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        LocaleKeys.view_all.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.primary(context),
                                      ),
                                    )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              switch (state) {
                                GetPatientAppointmentsLoading() =>
                                  ListView.separated(
                                    physics: const ClampingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 8),
                                    itemCount: 2,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return AppointmentCardShimmer();
                                    },
                                  ),
                                GetPatientAppointmentsLoaded(
                                  :final myAppointments
                                ) =>
                                  ListView.separated(
                                    physics: const ClampingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 8),
                                    itemCount: myAppointments.length > 2
                                        ? 2
                                        : myAppointments.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final appointment = myAppointments[index];
                                      return PatientAppointmentCard(
                                          appointment: appointment);
                                    },
                                  ),
                                GetPatientAppointmentsFailed(
                                  :final exception
                                ) =>
                                  CustomErrorWidget(
                                    exception: exception,
                                    onTap: () {
                                      context
                                          .read<
                                              GetPatientUpcomingAppointmentsBloc>()
                                          .add(GetMyAppointments());
                                    },
                                  ),
                                GetPatientAppointmentsInitial() =>
                                  const EmptyWidget(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
