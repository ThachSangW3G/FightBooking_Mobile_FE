import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleSearch extends StatelessWidget {
  const TitleSearch(
      {super.key,
      required this.title,
      required this.selected,
      required this.onClick});
  final String title;
  final bool selected;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? Color.fromARGB(255, 183, 217, 232) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: kLableSize15Black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
