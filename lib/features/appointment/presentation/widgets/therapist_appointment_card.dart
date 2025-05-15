import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/extensions/appointment_status_ext.dart';
import 'package:mini_health_appointment/core/extensions/date_time_ext.dart';
import 'package:mini_health_appointment/core/theme/text_style_ext.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/therapist_appointment_entity.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TherapistAppointmentCard extends StatelessWidget {
  final TherapistAppointmentEntity appointment;
  final void Function(AppointmentStatus)? onSelected;

  const TherapistAppointmentCard(
      {super.key, required this.appointment, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${LocaleKeys.patient_name.tr()}: "),
                          Text(
                            appointment.patientName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${LocaleKeys.message.tr()}: "),
                          Text(
                            appointment.message ?? "-",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                PopupMenuButton<AppointmentStatus>(
                  itemBuilder: (context) {
                    return AppointmentStatus.values.map(
                      (e) {
                        return PopupMenuItem<AppointmentStatus>(
                            value: e,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                  color: e.backgroundColor(context),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                e.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: e.textColor(context)),
                              ),
                            ));
                      },
                    ).toList();
                  },
                  onSelected: onSelected,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                        color: appointment.appointmentStatus
                            .backgroundColor(context),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      appointment.appointmentStatus.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              appointment.appointmentStatus.textColor(context)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.1)),
              child: Row(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhosphorIcon(
                    PhosphorIconsRegular.clock,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  Flexible(
                    child: Text(
                      appointment.date.toFormattedLongDate(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.outline(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
