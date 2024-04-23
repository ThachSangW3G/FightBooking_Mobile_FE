import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatefulWidget {
  final Function(String) onChanged;
  const OTPInput({super.key, required this.onChanged});

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 55,
      decoration: ShapeDecoration(
          color: AppColors.gray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: TextFormField(
        onChanged: widget.onChanged,
        style: Theme.of(context).textTheme.headlineSmall,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            enabledBorder: InputBorder.none, focusedBorder: InputBorder.none),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
