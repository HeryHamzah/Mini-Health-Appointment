import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/update_appointment_status_use_case.dart';

part 'update_appointment_status_event.dart';
part 'update_appointment_status_state.dart';

class UpdateAppointmentStatusBloc
    extends Bloc<UpdateAppointmentStatusEvent, UpdateAppointmentStatusState> {
  final UpdateAppointmentStatusUseCase updateAppointmentStatusUseCase;
  UpdateAppointmentStatusBloc({required this.updateAppointmentStatusUseCase})
      : super(UpdateAppointmentStatusInitial()) {
    on<UpdateAppointmentStatus>((event, emit) async {
      emit(UpdateAppointmentStatusLoading());

      final result = await updateAppointmentStatusUseCase(
          id: event.appointmentId, status: event.appointmentStatus);

      result.fold(
        (l) => emit(UpdateAppointmentStatusFailed(exception: l)),
        (r) => emit(UpdateAppointmentStatusSuccessful()),
      );
    });
  }
}
