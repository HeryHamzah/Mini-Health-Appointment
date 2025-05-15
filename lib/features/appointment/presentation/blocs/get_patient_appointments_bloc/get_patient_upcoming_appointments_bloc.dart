import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/get_upcoming_appointments_use_case.dart';

import '../get_appointments_event.dart';
import 'get_patient_appointments_state.dart';

class GetPatientUpcomingAppointmentsBloc
    extends Bloc<GetAppointmentsEvent, GetPatientAppointmentsState> {
  final GetUpcomingAppointmentsUseCase getUpcomingAppointmentsUseCase;
  GetPatientUpcomingAppointmentsBloc(
      {required this.getUpcomingAppointmentsUseCase})
      : super(GetPatientAppointmentsInitial()) {
    final int limit = 10;

    on<GetMyAppointments>((event, emit) async {
      emit(GetPatientAppointmentsLoading());

      final result =
          await getUpcomingAppointmentsUseCase(start: 0, limit: limit);

      result.fold(
          (l) => emit(
                GetPatientAppointmentsFailed(exception: l),
              ), (r) {
        if (r.isEmpty) {
          emit(GetPatientAppointmentsInitial());
        } else {
          emit(
            GetPatientAppointmentsLoaded(
              myAppointments: r,
              hasReachMax: r.length < limit,
            ),
          );
        }
      });
    });

    on<GetMoreMyAppointments>((event, emit) async {
      GetPatientAppointmentsLoaded myAppointmentsLoaded =
          state as GetPatientAppointmentsLoaded;

      final result = await getUpcomingAppointmentsUseCase(
          start: myAppointmentsLoaded.myAppointments.length, limit: limit);

      result.fold(
        (l) => emit(
          GetPatientAppointmentsFailed(exception: l),
        ),
        (r) => emit(
          GetPatientAppointmentsLoaded(
            myAppointments: myAppointmentsLoaded.myAppointments + r,
            hasReachMax: r.length < limit,
          ),
        ),
      );
    });
  }
}
