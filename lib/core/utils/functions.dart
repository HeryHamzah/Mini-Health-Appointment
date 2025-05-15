import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';

DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocaleKeys.form_validation_empty_email.tr();
  }

  // Regex sederhana untuk validasi email
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  if (!emailRegex.hasMatch(value.trim())) {
    return LocaleKeys.form_validation_incorrect_email_format.tr();
  }

  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return LocaleKeys.form_validation_empty_password.tr();
  }

  if (value.trim().length < 6) {
    return LocaleKeys.form_validation_min_six_character.tr();
  }

  return null;
}

String? confirmPasswordValidator(String? value, String originalPassword) {
  if (value == null || value.trim().isEmpty) {
    return LocaleKeys.form_validation_empty_confirm_password.tr();
  }

  if (value.trim() != originalPassword.trim()) {
    return LocaleKeys.form_validation_incorrect_confirm_password.tr();
  }

  return null;
}
