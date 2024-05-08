import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ChooseGender extends StatefulWidget {
  final Function(int) onChange;
  const ChooseGender({super.key, required this.onChange});

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới tính',
          style: kLableSize18w700Black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: _value,
                      activeColor: AppColors.dodger,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                          widget.onChange(value);
                        });
                      }),
                  Text(
                    'Nam',
                    style: kLableSize18w700Black,
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: _value,
                      activeColor: AppColors.dodger,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                          widget.onChange(value);
                        });
                      }),
                  Text(
                    'Nữ',
                    style: kLableSize18w700Black,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
