import 'package:flutter/material.dart';

class FlightPassengerContactWidget extends StatelessWidget {
  final String contactName;
  final String contactPhoneNumber;
  final String contactEmail;

  const FlightPassengerContactWidget({
    Key? key,
    required this.contactEmail,
    required this.contactName,
    required this.contactPhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'Thông tin liên hệ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        _buildTableRow('Họ tên', contactName),
        Divider(),
        _buildTableRow('Số điện thoại', contactPhoneNumber),
        Divider(),
        _buildTableRow('Email', contactEmail),
      ],
    );
  }

  Widget _buildTableRow(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8), // Khoảng cách giữa các dòng
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 7,
              child: Text(
                content,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
