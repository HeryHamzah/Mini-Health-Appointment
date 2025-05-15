import 'package:easy_localization/easy_localization.dart';
import 'package:mini_health_appointment/core/translations/locale_keys.g.dart';

extension FormattedDateExtension on DateTime {
  String toFormattedLongDate() {
    final now = DateTime.now();
    final isToday = year == now.year && month == now.month && day == now.day;

    final datePart = DateFormat('d MMMM y').format(this);
    final prefix =
        isToday ? LocaleKeys.today.tr() : DateFormat('EEEE').format(this);

    return '$prefix, $datePart';
  }

  String get formatDateSlash {
    return DateFormat('dd/MM/yy').format(this);
  }
}
