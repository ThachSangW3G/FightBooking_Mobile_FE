import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';

class TitleSwitch extends StatefulWidget {
  final String title;
  final String content;
  final bool value;
  final Function(bool) onChanged;
  const TitleSwitch(
      {super.key,
      required this.title,
      required this.content,
      required this.onChanged,
      required this.value});

  @override
  State<TitleSwitch> createState() => _TitleSwitchState();
}

class _TitleSwitchState extends State<TitleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: kLableTilteBlack,
                ),
                Text(
                  widget.content,
                  maxLines: 2,
                  style: kLableTextStyleMiniumGrey,
                )
              ],
            ),
          ),
          CupertinoSwitch(value: widget.value, onChanged: widget.onChanged)
        ],
      ),
    );
  }
}
