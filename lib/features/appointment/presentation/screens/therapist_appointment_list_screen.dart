import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/features/home/presentation/widgets/empty_widget.dart';

import '../../../home/presentation/widgets/custom_error_widget.dart';
import '../blocs/get_appointments_event.dart';
import '../blocs/get_therapist_appointments_bloc/get_therapist_appointments_bloc.dart';
import '../blocs/get_therapist_appointments_bloc/get_therapist_appointments_state.dart';
import '../blocs/update_appointment_status_bloc.dart/update_appointment_status_bloc.dart';
import '../widgets/appointment_card_shimmer.dart';
import '../widgets/therapist_appointment_card.dart';

class TherapistAppointmentListScreen extends StatefulWidget {
  const TherapistAppointmentListScreen({super.key});

  @override
  State<TherapistAppointmentListScreen> createState() =>
      _TherapistAppointmentListScreenState();
}

class _TherapistAppointmentListScreenState
    extends State<TherapistAppointmentListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (!(context.read<GetTherapistAppointmentsBloc>().state
                as GetTherapistAppointmentsLoaded)
            .hasReachMax) {
          context
              .read<GetTherapistAppointmentsBloc>()
              .add(GetMoreMyAppointments());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.appointment.tr(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocBuilder<GetTherapistAppointmentsBloc,
                GetTherapistAppointmentsState>(
              builder: (context, state) {
                switch (state) {
                  case GetTherapistAppointmentsLoading():
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: index == 0 ? 18.0 : 0,
                          ),
                          child: const AppointmentCardShimmer(),
                        );
                      },
                      itemCount: 10,
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                    );

                  case GetTherapistAppointmentsLoaded(
                      :final myAppointments,
                      :final hasReachMax
                    ):
                    return ListView.separated(
                      controller: _scrollController,
                      itemCount: hasReachMax
                          ? myAppointments.length
                          : myAppointments.length + 1,
                      physics: const ClampingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        if (index < myAppointments.length) {
                          final appointment = myAppointments[index];
                          return TherapistAppointmentCard(
                            appointment: appointment,
                            onSelected: (p0) {
                              if (p0 != appointment.appointmentStatus) {
                                context.read<UpdateAppointmentStatusBloc>().add(
                                      UpdateAppointmentStatus(
                                          appointmentStatus: p0,
                                          appointmentId:
                                              appointment.appointmentId),
                                    );
                              }
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );

                  case GetTherapistAppointmentsFailed(:final exception):
                    return Center(
                      child: CustomErrorWidget(
                        exception: exception,
                        onTap: () {
                          context
                              .read<GetTherapistAppointmentsBloc>()
                              .add(GetMyAppointments());
                        },
                      ),
                    );

                  case GetTherapistAppointmentsInitial():
                    return EmptyWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
