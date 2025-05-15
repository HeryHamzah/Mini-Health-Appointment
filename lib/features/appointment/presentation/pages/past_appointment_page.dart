import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/widgets/custom_error_widget.dart';
import '../../../home/presentation/widgets/empty_widget.dart';
import '../blocs/get_appointments_event.dart';
import '../blocs/get_patient_appointments_bloc/get_patient_appointments_state.dart';
import '../blocs/get_patient_appointments_bloc/get_patient_past_appointments_bloc.dart';
import '../widgets/patient_appointment_card.dart';
import '../widgets/appointment_card_shimmer.dart';

class PastAppointmentPage extends StatefulWidget {
  const PastAppointmentPage({super.key});

  @override
  State<PastAppointmentPage> createState() => _PastAppointmentPageState();
}

class _PastAppointmentPageState extends State<PastAppointmentPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (!(context.read<GetPatientPastAppointmentsBloc>().state
                as GetPatientAppointmentsLoaded)
            .hasReachMax) {
          context
              .read<GetPatientPastAppointmentsBloc>()
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
      child: BlocBuilder<GetPatientPastAppointmentsBloc,
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
                        .read<GetPatientPastAppointmentsBloc>()
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
