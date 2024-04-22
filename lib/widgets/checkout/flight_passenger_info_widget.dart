import 'package:flutter/material.dart';

class FlightPassenserInfoWidget extends StatelessWidget {
  final List<String> customers; // Danh sách tên khách hàng

  const FlightPassenserInfoWidget({
    Key? key,
    required this.customers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin khách hàng',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        // Hiển thị danh sách tên khách hàng
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: customers.map((customer) => Text(customer)).toList(),
        ),
        // Các trường thông tin khác có thể thêm vào ở đây
      ],
    );
  }
}
