import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/features/appointment/domain/entities/appointment_status.dart';

extension AppointmentStatusExt on AppointmentStatus {
  String get title {
    switch (this) {
      case AppointmentStatus.pending:
        return LocaleKeys.pending.tr();
      case AppointmentStatus.completed:
        return LocaleKeys.completed.tr();
      case AppointmentStatus.cancelled:
        return LocaleKeys.canceled.tr();
      case AppointmentStatus.isNew:
        return LocaleKeys.is_new.tr();
    }
  }

  Color backgroundColor(BuildContext context) {
    switch (this) {
      case AppointmentStatus.pending:
        return Theme.of(context).colorScheme.tertiary;
      case AppointmentStatus.completed:
        return Theme.of(context).colorScheme.primary;
      case AppointmentStatus.cancelled:
        return Theme.of(context).colorScheme.error;
      case AppointmentStatus.isNew:
        return Theme.of(context).colorScheme.primaryContainer;
    }
  }

  Color textColor(BuildContext context) {
    switch (this) {
      case AppointmentStatus.pending:
        return Theme.of(context).colorScheme.onTertiary;
      case AppointmentStatus.completed:
        return Theme.of(context).colorScheme.onPrimary;
      case AppointmentStatus.cancelled:
        return Theme.of(context).colorScheme.onError;
      case AppointmentStatus.isNew:
        return Theme.of(context).colorScheme.onPrimaryContainer;
    }
  }
}
