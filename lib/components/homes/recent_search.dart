import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_styles.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'HAN - Hà Nội, Việt Nam',
            style: kLableSize15Black,
          ),
          SvgPicture.asset(
            'assets/icons/close.svg',
            color: AppColors.gray,
            height: 30,
            width: 30,
          )
        ],
      ),
    );
  }
}
