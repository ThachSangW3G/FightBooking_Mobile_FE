import 'package:flutter/material.dart';

class FlightPriceDetailsWidget extends StatelessWidget {
  final int adults;
  final int children;
  final int infants;
  final int priceAdult;
  final int priceChild;
  final int priceInfant;
  final int totalPrice;

  const FlightPriceDetailsWidget({
    Key? key,
    required this.adults,
    required this.children,
    required this.infants,
    required this.priceAdult,
    required this.priceChild,
    required this.priceInfant,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (adults > 0)
          _buildPriceRow("người lớn", adults, priceAdult * adults),
        if (children > 0)
          _buildPriceRow("trẻ em", children, priceChild * children),
        if (infants > 0)
          _buildPriceRow("em bé", infants, priceInfant * infants),
        _buildTotalRow("Tổng cộng", totalPrice),
      ],
    );
  }

  Widget _buildPriceRow(String title, int count, int price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$count $title",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "\$$price",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Divider(),
      ],
    );
  }

  Widget _buildTotalRow(String title, int totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$$totalPrice",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
