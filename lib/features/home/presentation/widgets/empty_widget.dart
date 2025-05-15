import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/translations/locale_keys.g.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhosphorIcon(
          PhosphorIconsDuotone.empty,
          size: 40,
          duotoneSecondaryColor: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(
          height: 8,
        ),
        Text(LocaleKeys.empty_data.tr().toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }
}
