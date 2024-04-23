import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonIcon extends StatelessWidget {
  final String icon;
  final VoidCallback onPress;
  const ButtonIcon({super.key, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 110,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.green),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
