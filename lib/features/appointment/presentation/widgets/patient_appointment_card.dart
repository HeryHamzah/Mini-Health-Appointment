import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/extensions/appointment_status_ext.dart';
import 'package:mini_health_appointment/core/extensions/date_time_ext.dart';
import 'package:mini_health_appointment/core/shared/cached_image_widget.dart';
import 'package:mini_health_appointment/core/theme/text_style_ext.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../domain/entities/patient_appointment_entity.dart';

class PatientAppointmentCard extends StatelessWidget {
  final PatientAppointmentEntity appointment;
  const PatientAppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: CachedImageWidget(
                    uri: appointment.therapist.profilePicPath,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        appointment.therapist.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        appointment.therapist.role ?? "-",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                Container(
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
                )
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
