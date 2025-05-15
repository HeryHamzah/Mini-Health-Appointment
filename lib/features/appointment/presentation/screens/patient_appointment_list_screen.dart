import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';
import 'package:mini_health_appointment/features/appointment/presentation/pages/past_appointment_page.dart';
import 'package:mini_health_appointment/features/appointment/presentation/pages/upcoming_appointment_page.dart';

class PatientAppointmentListScreen extends StatelessWidget {
  const PatientAppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.appointment.tr(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withValues(alpha: 0.40),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TabBar(
                        dividerColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              24,
                            ),
                            color: Theme.of(context).colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.10),
                                  offset: Offset(0, 4),
                                  blurRadius: 20),
                            ]),
                        tabs: [
                          Tab(
                            text: LocaleKeys.upcoming.tr(),
                          ),
                          Tab(
                            text: LocaleKeys.past.tr(),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: TabBarView(children: [
                    UpcomingAppointmentPage(),
                    PastAppointmentPage(),
                  ]))
                ],
              )),
        ),
      ),
    );
  }
}
