import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';

part 'create_appointment_form_event.dart';
part 'create_appointment_form_state.dart';

class CreateAppointmentFormBloc
    extends Bloc<CreateAppointmentFormEvent, CreateAppointmentFormState> {
  CreateAppointmentFormBloc() : super(CreateAppointmentFormState()) {
    on<ChangeAppointmentValue>((event, emit) {
      emit(state.copyWith(
        message: event.message,
        patientName: event.patientName,
        selectedDate: event.selectedDate,
        selectedTherapist: event.selectedTherapist,
        selectedTime: event.selectedTime,
      ));
    });
  }
}
