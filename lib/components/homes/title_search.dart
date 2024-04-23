import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';

class TitleSearch extends StatelessWidget {
  const TitleSearch({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: kLableSize15Black,
          ),
        ],
      ),
    );
  }
}
