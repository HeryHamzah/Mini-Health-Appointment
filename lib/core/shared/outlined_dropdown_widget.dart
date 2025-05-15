import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OutlinedDropdownWidget<T> extends StatelessWidget {
  final String? Function(T?)? validator;
  final bool enabled;
  final String? hintText;
  final String Function(T) itemAsString;
  final List<T> items;
  final void Function(T?)? onChanged;
  final Widget Function(BuildContext, T?)? dropdownBuilder;
  final bool Function(T, T)? compareFn;
  final T? selectedItem;
  final TextStyle? hintStyle;
  final TextStyle? baseStyle;
  final TextStyle? menuItemStyle;
  final bool showOutline;
  final Widget Function(BuildContext, T, bool, bool)? itemBuilder;

  const OutlinedDropdownWidget({
    super.key,
    this.validator,
    this.enabled = true,
    this.hintText,
    required this.itemAsString,
    this.items = const [],
    this.onChanged,
    this.dropdownBuilder,
    this.compareFn,
    this.selectedItem,
    this.hintStyle,
    this.baseStyle,
    this.menuItemStyle,
    this.showOutline = true,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      itemAsString: itemAsString,
      items: (filter, loadProps) => items,
      compareFn: compareFn,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      selectedItem: selectedItem,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      dropdownBuilder: dropdownBuilder ??
          (context, selectedItem) => selectedItem != null
              ? Text(
                  itemAsString(selectedItem),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : const SizedBox(),
      decoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: hintStyle,

            //when focused
            focusedBorder: showOutline
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8))
                : InputBorder.none,

            //when enable
            enabledBorder: showOutline
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8))
                : InputBorder.none,

            //when click or select item
            border: showOutline
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8))
                : InputBorder.none,
          )),
      suffixProps: const DropdownSuffixProps(
          dropdownButtonProps: DropdownButtonProps(
              iconOpened: PhosphorIcon(PhosphorIconsThin.caretUp),
              iconClosed: PhosphorIcon(PhosphorIconsThin.caretDown))),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        itemBuilder: itemBuilder ??
            (context, item, isDisabled, isSelected) {
              return ListTile(
                // visualDensity: VisualDensity.compact,
                dense: true,
                title: Text(
                  itemAsString(item),
                ),
              );
            },
        menuProps: MenuProps(
          popUpAnimationStyle: AnimationStyle(duration: Duration.zero),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        emptyBuilder: (context, searchEntry) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "no_data_available".tr(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
