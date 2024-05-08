import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberField extends StatefulWidget {
  final String label;
  final String hinttext;
  final String name;
  final ValueChanged<String> onChanged;

  const InputNumberField(
      {super.key,
      required this.label,
      required this.name,
      required this.hinttext,
      required this.onChanged});

  @override
  State<InputNumberField> createState() => _InputNumberComponentState();
}

class _InputNumberComponentState extends State<InputNumberField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: kLableSize18w700Black,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.name,
            validator: (value) =>
                (value?.isEmpty ?? true) ? 'Title is required' : null,
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
                hintText: widget.hinttext,
                enabledBorder: const OutlineInputBorder(
                  // viền khi không có focus
                  borderSide: BorderSide(color: AppColors.gray),
                ),
                focusedBorder: const OutlineInputBorder(
                  // viền khi có focus
                  borderSide: BorderSide(color: AppColors.dodger),
                ),
                labelStyle: const TextStyle(
                    fontFamily: 'CeraPro',
                    // fontSize: 14,
                    fontWeight: FontWeight.w400),
                filled: true,
                fillColor: AppColors.white),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
    );
  }
}
