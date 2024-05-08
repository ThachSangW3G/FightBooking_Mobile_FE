import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';

class InputSelectData extends StatefulWidget {
  final String label;
  final String hinttext;
  final String selectedOption;
  final Function(String) onChanged;
  final List<String> list;
  const InputSelectData(
      {super.key,
      required this.list,
      required this.selectedOption,
      required this.onChanged,
      required this.label,
      required this.hinttext});

  @override
  State<InputSelectData> createState() => _InputSelectState();
}

class _InputSelectState extends State<InputSelectData> {
  String? value;
  String dropdownValue = 'Nam';
  @override
  void initState() {
    value = widget.selectedOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label),
            const Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: AppColors.whitePorcelain,
              border: Border.all(width: 1, color: AppColors.greyIron),
              borderRadius: BorderRadius.circular(4)),
          child: DropdownButton(
            value: value,
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
              if (newValue != null) widget.onChanged(newValue);
            },
            hint: Text(widget.hinttext),
            dropdownColor: AppColors.whitePorcelain,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 20,
            underline: const SizedBox(),
            isExpanded: true,
            style: const TextStyle(color: Colors.black),
            items: widget.list.map((valueitem) {
              return DropdownMenuItem(value: valueitem, child: Text(valueitem));
            }).toList(),
          ),
        ),
      ],
    ));
  }
}
