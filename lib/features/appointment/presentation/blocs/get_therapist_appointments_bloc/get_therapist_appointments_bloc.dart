import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/get_therapist_upcoming_appointments_use_case.dart';

import '../get_appointments_event.dart';
import 'get_therapist_appointments_state.dart';

class GetTherapistAppointmentsBloc
    extends Bloc<GetAppointmentsEvent, GetTherapistAppointmentsState> {
  final GetTherapistAppointmentsUseCase getTherapistAppointmentsUseCase;
  GetTherapistAppointmentsBloc({required this.getTherapistAppointmentsUseCase})
      : super(GetTherapistAppointmentsInitial()) {
    final int limit = 10;

    on<GetMyAppointments>((event, emit) async {
      emit(GetTherapistAppointmentsLoading());

      final result =
          await getTherapistAppointmentsUseCase(start: 0, limit: limit);

      result.fold(
          (l) => emit(
                GetTherapistAppointmentsFailed(exception: l),
              ), (r) {
        if (r.isEmpty) {
          emit(GetTherapistAppointmentsInitial());
        } else {
          emit(
            GetTherapistAppointmentsLoaded(
              myAppointments: r,
              hasReachMax: r.length < limit,
            ),
          );
        }
      });
    });

    on<GetMoreMyAppointments>((event, emit) async {
      GetTherapistAppointmentsLoaded myAppointmentsLoaded =
          state as GetTherapistAppointmentsLoaded;

      final result = await getTherapistAppointmentsUseCase(
          start: myAppointmentsLoaded.myAppointments.length, limit: limit);

      result.fold(
        (l) => emit(
          GetTherapistAppointmentsFailed(exception: l),
        ),
        (r) => emit(
          GetTherapistAppointmentsLoaded(
            myAppointments: myAppointmentsLoaded.myAppointments + r,
            hasReachMax: r.length < limit,
          ),
        ),
      );
    });
  }
}
