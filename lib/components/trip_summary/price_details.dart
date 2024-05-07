import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';

class PriceDetails extends StatelessWidget {
  final int adults;
  final int children;
  final int infants;
  final int priceAdult;
  final int priceChild;
  final int priceInfant;
  final int disCount;
  final int priceTax;
  final int priceLuggage;
  final int priceProcedure;
  final String type;
  final String start;
  final String end;
  final int totalPrice;
  const PriceDetails(
      {super.key,
      required this.adults,
      required this.children,
      required this.infants,
      required this.priceAdult,
      required this.priceChild,
      required this.priceInfant,
      required this.totalPrice,
      required this.disCount,
      required this.priceTax,
      required this.priceLuggage,
      required this.priceProcedure,
      required this.type,
      required this.start,
      required this.end});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (type == 'go')
            _buildTextTitleRow('Chuyến đi', '$start-$end')
          else
            _buildTextTitleRow('Chuyến về', '$start-$end'),
          if (adults > 0)
            _buildPriceRow("người lớn", adults, priceAdult * adults),
          if (children > 0)
            _buildPriceRow("trẻ em", children, priceChild * children),
          if (infants > 0)
            _buildPriceRow("em bé", infants, priceInfant * infants),
          _buildTextRow('Thuế', priceTax.toString()),
          _buildTextRow('Hành lý', priceLuggage.toString()),
          _buildTextRow('Thủ tục ưu tiên', priceProcedure.toString()),
          _buildTextRow('Giảm giá', '- $disCount'),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, int count, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$count $title', style: kLableSize18Black),
        Text("$price đ", style: kLableSize18Black),
      ],
    );
  }

  Widget _buildTextRow(String title, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kLableSize18Black),
        Text('$price đ', style: kLableSize18Black),
      ],
    );
  }

  Widget _buildTextTitleRow(String title, String des) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kLableSize18w700Black),
        Text(des, style: kLableSize18w700Black),
      ],
    );
  }
}
