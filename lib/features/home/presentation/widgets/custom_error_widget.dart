import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mini_health_appointment/core/theme/text_style_ext.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/translations/locale_keys.g.dart';

class CustomErrorWidget extends StatelessWidget {
  final AppException exception;
  final void Function()? onTap;
  const CustomErrorWidget({super.key, required this.exception, this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget buildErrorIcon() {
      switch (exception) {
        case ServerException():
          return PhosphorIcon(
            PhosphorIconsDuotone.cloudX,
            size: 40,
            duotoneSecondaryColor: Theme.of(context).colorScheme.primary,
          );
        case ClientException():
          return PhosphorIcon(
            PhosphorIconsDuotone.globeX,
            size: 40,
            duotoneSecondaryColor: Theme.of(context).colorScheme.primary,
          );
        default:
          return PhosphorIcon(
            PhosphorIconsDuotone.warning,
            size: 40,
            duotoneSecondaryColor: Theme.of(context).colorScheme.primary,
          );
      }
    }

    return Column(
      children: [
        buildErrorIcon(),
        SizedBox(
          height: 8,
        ),
        Text(exception.message.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge),
        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            LocaleKeys.try_again.tr(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.primary(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
