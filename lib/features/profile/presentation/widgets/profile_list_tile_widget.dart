import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileListTileWidget extends StatelessWidget {
  final IconData leading;
  final String title;
  final Color? withColor;
  final void Function()? onTap;
  const ProfileListTileWidget(
      {super.key,
      required this.leading,
      required this.title,
      this.withColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: PhosphorIcon(
        leading,
        size: 20,
        color: withColor,
      ),
      title: Text(
        title,
        style: withColor != null
            ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: withColor)
            : Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: PhosphorIcon(
        PhosphorIconsBold.caretRight,
        size: 16,
        color: withColor,
      ),
    );
  }
}
