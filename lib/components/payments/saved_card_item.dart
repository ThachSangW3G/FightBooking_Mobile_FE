import 'package:flutter/material.dart';

class SavedCardItem extends StatelessWidget {
  final String paymentMethodId;
  final String cardLast4;
  final String cardBrand;
  final String? selectedCard;
  final Function(String?) onChanged;
  final Function onDelete;

  SavedCardItem({
    required this.paymentMethodId,
    required this.cardLast4,
    required this.cardBrand,
    required this.selectedCard,
    required this.onChanged,
    required this.onDelete,
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
            value: paymentMethodId,
            groupValue: selectedCard,
            onChanged: onChanged,
          ),
          Text('$cardBrand **** $cardLast4'),
          TextButton(
            onPressed: () => onDelete(),
            child: Text('Xóa thẻ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
