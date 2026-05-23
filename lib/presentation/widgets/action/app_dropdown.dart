import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme/theme_colors.dart';
import '../../../core/theme/theme_styles.dart';

class DropDownWidget extends StatelessWidget {
  final String? value;
  final String label;
  final FocusNode? focus;
  final List<String>? items;
  final EdgeInsetsGeometry? margin;
  final ValueChanged<String>? onChanged;

  const DropDownWidget({
    super.key,
    this.value,
    required this.items,
    this.focus,
    this.label = '',
    this.onChanged,
    this.margin,
  }) : assert(items != null);

  @override
  Widget build(BuildContext context) {
    var labelWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ).padding(top: Sizes.sm);

    var inputWidget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        focusNode: focus,
        borderRadius: BorderRadius.circular(10),
        onChanged: (String? newValue) => onChanged!(newValue!),
        items: items!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ).padding(left: 10),
          );
        }).toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ).padding(horizontal: 10),
        underline: const SizedBox.shrink(),
      ),
    );

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty) ...[labelWidget],
          const SizedBox(height: 5),
          inputWidget,
        ],
      ),
    );
  }
}

class AppDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String label;
  final String Function(T) getItemLabel;
  final void Function(T?)? onChanged;
  final EdgeInsetsGeometry? margin;

  const AppDropdown({
    super.key,
    required this.items,
    required this.getItemLabel,
    this.value,
    this.label = '',
    this.onChanged,
    this.margin,
  });

  @override
  AppDropdownState<T> createState() => AppDropdownState<T>();
}

class AppDropdownState<T> extends State<AppDropdown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    var labelWidget = Text(
      widget.label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ).padding(top: Sizes.sm);

    var buttonWidget = DropdownButton<T>(
      value: selectedValue,
      isExpanded: true,
      borderRadius: BorderRadius.circular(6),
      onChanged: (T? newValue) {
        setState(() {
          selectedValue = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      items: widget.items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            widget.getItemLabel(value),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ).padding(left: 10),
        );
      }).toList(),
        underline: const SizedBox.shrink(),
    );

    return Container(
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label.isNotEmpty) ...[labelWidget],
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: ThemeColors.darkGray, width: 1),
            ),
            child: buttonWidget,
          ),
        ],
      ),
    );
  }
}
