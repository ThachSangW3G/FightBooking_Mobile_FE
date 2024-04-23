import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LineBlueLong extends StatelessWidget {
  const LineBlueLong({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 5.26,
      decoration: ShapeDecoration(
        color: AppColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}
