import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_health_appointment/core/extensions/date_time_ext.dart';
import 'package:mini_health_appointment/core/extensions/red_asterisk_extension.dart';
import 'package:mini_health_appointment/core/router/route_app.dart';
import 'package:mini_health_appointment/core/shared/full_screen_loading_widget.dart';
import 'package:mini_health_appointment/core/shared/outlined_dropdown_widget.dart';
import 'package:mini_health_appointment/core/shared/outlined_text_field.dart';
import 'package:mini_health_appointment/core/utils/functions.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/create_appointment_bloc/create_appointment_bloc.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_appointments_event.dart';
import 'package:mini_health_appointment/features/appointment/presentation/blocs/get_patient_appointments_bloc/get_patient_upcoming_appointments_bloc.dart';
import 'package:mini_health_appointment/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';
import 'package:mini_health_appointment/features/therapist/presentation/blocs/get_therapist_bloc/get_therapists_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/translations/locale_keys.g.dart';
import '../blocs/create_appointment_form_bloc/create_appointment_form_bloc.dart';
import '../blocs/get_patient_appointments_bloc/get_patient_past_appointments_bloc.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _patientNameController;
  late final TextEditingController _yourMessageController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;

  @override
  void initState() {
    super.initState();

    _patientNameController = TextEditingController();
    _yourMessageController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();

    _patientNameController.addListener(() {
      context.read<CreateAppointmentFormBloc>().add(
          ChangeAppointmentValue(patientName: _patientNameController.text));
    });

    _yourMessageController.addListener(() {
      context
          .read<CreateAppointmentFormBloc>()
          .add(ChangeAppointmentValue(message: _yourMessageController.text));
    });
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _yourMessageController.dispose();
    super.dispose();
  }

  submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final dataForm = context.read<CreateAppointmentFormBloc>().state;

      context.read<CreateAppointmentBloc>().add(
            CreateAppointment(
              dateAndTime: combineDateAndTime(
                  dataForm.selectedDate!, dataForm.selectedTime!),
              therapist: dataForm.selectedTherapist!,
              patientName: dataForm.patientName!,
              message: dataForm.message,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAppointmentBloc, CreateAppointmentState>(
      listener: (context, state) {
        if (state is CreateAppointmentSuccessful) {
          context
              .read<GetPatientUpcomingAppointmentsBloc>()
              .add(GetMyAppointments());
          context
              .read<GetPatientPastAppointmentsBloc>()
              .add(GetMyAppointments());
          context.goNamed(RouteName.main);
        } else if (state is CreateAppointmentFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.exception.message)));
        }
      },
      child: BlocBuilder<CreateAppointmentFormBloc, CreateAppointmentFormState>(
        builder: (context, formState) {
          return Stack(
            children: [
              Scaffold(
                body: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              LocaleKeys.patient.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ).withRedAsterisk(context),
                            SizedBox(
                              height: 10,
                            ),
                            OutlinedTextField(
                              controller: _patientNameController,
                              hintText: LocaleKeys.patient_name.tr(),
                              onChanged: (p0) {
                                context.read<CreateAppointmentFormBloc>().add(
                                    ChangeAppointmentValue(patientName: p0));
                              },
                              validator: (p0) {
                                if (p0 == null || p0.trim().isEmpty) {
                                  return LocaleKeys
                                      .form_validation_empty_patient_name
                                      .tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              LocaleKeys.therapist.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ).withRedAsterisk(context),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<GetTherapistsBloc, GetTherapistsState>(
                              builder: (context, state) {
                                return OutlinedDropdownWidget<TherapistEntity>(
                                  hintText: LocaleKeys.select_therapist.tr(),
                                  itemAsString: (p0) => p0.name,
                                  items: state is GetTherapistsLoaded
                                      ? state.therapists
                                      : [],
                                  onChanged: (p0) {
                                    context
                                        .read<CreateAppointmentFormBloc>()
                                        .add(ChangeAppointmentValue(
                                            selectedTherapist: p0));
                                  },
                                  compareFn: (p0, p1) => p0.id != p1.id,
                                  validator: (p0) {
                                    if (p0 == null) {
                                      return LocaleKeys
                                          .form_validation_empty_therapist
                                          .tr();
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.appointment_date.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ).withRedAsterisk(context),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now(),
                                              initialDate:
                                                  formState.selectedDate ??
                                                      DateTime.now(),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 7)));

                                          if (date == null) {
                                            return;
                                          }

                                          if (context.mounted) {
                                            context
                                                .read<
                                                    CreateAppointmentFormBloc>()
                                                .add(ChangeAppointmentValue(
                                                    selectedDate: date));

                                            _dateController.text =
                                                date.formatDateSlash;
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: OutlinedTextField(
                                            hintText: LocaleKeys.select.tr(),
                                            suffixIcon: PhosphorIcon(
                                                PhosphorIconsRegular
                                                    .calendarDots),
                                            controller: _dateController,
                                            validator: (p0) {
                                              if (p0 == null ||
                                                  p0.trim().isEmpty) {
                                                return LocaleKeys
                                                    .form_validation_empty_date
                                                    .tr();
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.apppointment_hour.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ).withRedAsterisk(context),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final hour = await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  formState.selectedTime ??
                                                      TimeOfDay.now());

                                          if (hour == null) {
                                            return;
                                          }

                                          if (context.mounted) {
                                            context
                                                .read<
                                                    CreateAppointmentFormBloc>()
                                                .add(ChangeAppointmentValue(
                                                    selectedTime: hour));

                                            _timeController.text =
                                                hour.format(context);
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: OutlinedTextField(
                                            hintText: LocaleKeys.select.tr(),
                                            suffixIcon: PhosphorIcon(
                                                PhosphorIconsRegular.clock),
                                            controller: _timeController,
                                            validator: (p0) {
                                              if (p0 == null ||
                                                  p0.trim().isEmpty) {
                                                return LocaleKeys
                                                    .form_validation_empty_time
                                                    .tr();
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              LocaleKeys.your_message.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OutlinedTextField(
                              controller: _yourMessageController,
                              maxLines: 5,
                              hintText: LocaleKeys.your_message.tr(),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            FilledButton(
                                onPressed: () {
                                  submit();
                                },
                                child: Text(LocaleKeys.submit.tr()))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (context.watch<GetTherapistsBloc>().state
                      is GetTherapistsLoading ||
                  context.watch<ProfileBloc>().state is ProfileLoading ||
                  context.watch<CreateAppointmentBloc>().state
                      is CreateAppointmentLoading)
                FullScreenLoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
