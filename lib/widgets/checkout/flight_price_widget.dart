import 'package:flutter/material.dart';

class FlightPriceDetailsWidget extends StatelessWidget {
  final int adults;
  final double priceAdult;
  final int infants;
  final double priceInfant;
  final int children;
  final double priceChild;
  final String tax;
  final String baggage;
  final double priceBaggage;
  final double priceInsurance;

  const FlightPriceDetailsWidget({
    Key? key,
    required this.adults,
    required this.priceAdult,
    required this.infants,
    required this.priceInfant,
    required this.children,
    required this.priceChild,
    required this.tax,
    required this.baggage,
    required this.priceBaggage,
    required this.priceInsurance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chi tiết giá',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text('Adults: $adults - Price: $priceAdult'),
        Text('Infants: $infants - Price: $priceInfant'),
        Text('Children: $children - Price: $priceChild'),
        Text('Tax: $tax'),
        Text('Baggage: $baggage - Price Baggage: $priceBaggage'),
        Text('Price Insurance: $priceInsurance'),
        // Các thông tin khác có thể thêm vào ở đây
      ],
    );
  }
}
