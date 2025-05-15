import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_appointments_event.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_appointments_state.dart';
import 'package:mini_health_appointment/features/appointment/presentation/widgets/appointment_card_shimmer.dart';
import 'package:mini_health_appointment/features/home/presentation/widgets/custom_error_widget.dart';
import 'package:mini_health_appointment/features/home/presentation/widgets/empty_widget.dart';

import '../blocs/get_patient_appointments_bloc/get_patient_upcoming_appointments_bloc.dart';
import '../widgets/patient_appointment_card.dart';

class UpcomingAppointmentPage extends StatefulWidget {
  const UpcomingAppointmentPage({super.key});

  @override
  State<UpcomingAppointmentPage> createState() =>
      _UpcomingAppointmentPageState();
}

class _UpcomingAppointmentPageState extends State<UpcomingAppointmentPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<GetPatientUpcomingAppointmentsBloc,
          GetPatientAppointmentsState>(
        builder: (context, state) {
          switch (state) {
            case GetPatientAppointmentsLoading():
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

            case GetPatientAppointmentsLoaded(
                :final myAppointments,
                :final hasReachMax
              ):
              return ListView.separated(
                controller: _scrollController,
                itemCount: hasReachMax
                    ? myAppointments.length
                    : myAppointments.length + 1,
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index < myAppointments.length) {
                    final appointment = myAppointments[index];
                    return PatientAppointmentCard(appointment: appointment);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );

            case GetPatientAppointmentsFailed(:final exception):
              return Center(
                child: CustomErrorWidget(
                  exception: exception,
                  onTap: () {
                    context
                        .read<GetPatientUpcomingAppointmentsBloc>()
                        .add(GetMyAppointments());
                  },
                ),
              );

            case GetPatientAppointmentsInitial():
              return EmptyWidget();
          }
        },
      ),
    );
  }
}
