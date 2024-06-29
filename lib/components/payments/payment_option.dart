import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String value;
  final String imagePath;
  final String title;
  final String? groupValue;
  final Function(String?) onChanged;
  final Widget? child;

  PaymentOption({
    required this.value,
    required this.imagePath,
    required this.title,
    required this.groupValue,
    required this.onChanged,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(title),
          leading: Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          trailing: Image.asset(imagePath, width: 100, height: 50),
        ),
        if (child != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: child,
          ),
      ],
    );
  }
}
