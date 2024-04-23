import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class ButtonIconBlue extends StatefulWidget {
  const ButtonIconBlue({super.key, required this.icon});
  final String icon;

  @override
  State<ButtonIconBlue> createState() => _ButtonIconBlueState();
}

class _ButtonIconBlueState extends State<ButtonIconBlue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: AppColors.blue)),
      child: Center(
        child: SvgPicture.asset(widget.icon),
      ),
    );
  }
}
