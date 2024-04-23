import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class LineBlueSort extends StatelessWidget {
  const LineBlueSort({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
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
