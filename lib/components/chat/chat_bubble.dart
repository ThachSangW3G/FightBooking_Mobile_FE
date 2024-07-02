import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final VoidCallback onPressed;

  const ChatBubble({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color:
              AppColors.lightGray.withOpacity(0.7), // Adjust the opacity here
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.send, color: Colors.black),
      ),
    );
  }
}
