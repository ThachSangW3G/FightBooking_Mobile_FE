import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTimePicker extends StatefulWidget {
  final String label;
  final String hinttext;
  final String? name;
  final ValueChanged<DateTime> onChanged;

  const InputTimePicker(
      {super.key,
      required this.label,
      required this.name,
      required this.hinttext,
      required this.onChanged});

  @override
  State<InputTimePicker> createState() => _InputNumberComponentState();
}

class _InputNumberComponentState extends State<InputTimePicker> {
  DateTime? selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onChanged(selectedDate!);
    }
  }

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
            //initialValue: widget.name ?? 'DD/MM/YYYY',
            validator: (value) =>
                (value?.isEmpty ?? true) ? 'Title is required' : null,
            readOnly: true,
            controller: TextEditingController(
              text: selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                  : widget.name,
            ),
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
                suffixIcon: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: const Icon(Icons.date_range_outlined),
                ),
                fillColor: AppColors.white),
          ),
        ],
      ),
    );
  }
}
