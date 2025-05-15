import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';

import '../../domain/entities/patient_appointment_entity.dart';

class PatientAppointmentDetailScreen extends StatelessWidget {
  final PatientAppointmentEntity appointment;
  const PatientAppointmentDetailScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.detail.tr()),
      ),
      body: ListView(
        children: [
          // Container(
          //   child: CachedImageWidget(
          //     uri: appointment.,
          //   ),
          // )
        ],
      ),
    );
  }
}
