import 'package:flutter/material.dart';

class NewCardOption extends StatelessWidget {
  final String? selectedCard;
  final Function(String?) onChanged;
  final Function onSave;

  NewCardOption({
    required this.selectedCard,
    required this.onChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: 'new_card',
            groupValue: selectedCard,
            onChanged: onChanged,
          ),
          Expanded(child: Text('Thanh toán bằng thẻ mới')),
        ],
      ),
    );
  }
}
