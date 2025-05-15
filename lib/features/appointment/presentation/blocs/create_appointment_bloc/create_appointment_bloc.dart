import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';
import 'package:mini_health_appointment/features/appointment/domain/usecases/create_appointment_use_case.dart';

part 'create_appointment_event.dart';
part 'create_appointment_state.dart';

class CreateAppointmentBloc
    extends Bloc<CreateAppointmentEvent, CreateAppointmentState> {
  final CreateAppointmentUseCase createAppointmentUseCase;
  CreateAppointmentBloc({required this.createAppointmentUseCase})
      : super(CreateAppointmentInitial()) {
    on<CreateAppointment>((event, emit) async {
      emit(CreateAppointmentLoading());

      final result = await createAppointmentUseCase(
        dateAndTime: event.dateAndTime,
        patientName: event.patientName,
        therapist: event.therapist,
        message: event.message,
      );

      result.fold(
        (l) => emit(
          CreateAppointmentFailed(exception: l),
        ),
        (r) => emit(
          CreateAppointmentSuccessful(),
        ),
      );
    });
  }
}
