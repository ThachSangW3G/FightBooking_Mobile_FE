import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Đảm bảo đã thêm thư viện intl vào pubspec.yaml

class FlightTicketWidget extends StatelessWidget {
  final String status;
  final String depart;
  final String arrive;
  final String departCode;
  final String arriveCode;
  final int totalPrice;
  final String id;

  const FlightTicketWidget({
    Key? key,
    required this.status,
    required this.depart,
    required this.arrive,
    required this.departCode,
    required this.arriveCode,
    required this.totalPrice,
    required this.id,
  }) : super(key: key);
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Xuất vé thành công':
        return Colors.lightGreen;
      case 'Đang giữ chỗ':
        return Colors.yellow;
      case 'Xuất vé thất bại':
        return Colors.red;
      default:
        return Colors.grey; // Màu mặc định nếu không phải 3 trạng thái trên
    }
  }

  Color _getTextColor(String status) {
    switch (status) {
      case 'Xuất vé thành công':
        return Colors.green[700]!; // Sử dụng mã màu đậm hơn
      case 'Đang giữ chỗ':
        return Colors.brown; // Hoặc màu nào đó phù hợp với thiết kế của bạn
      case 'Xuất vé thất bại':
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tạo một formatter để hiển thị giá tiền đúng định dạng
    final currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    // Định dạng giá tiền với formatter
    String formattedPrice = currencyFormatter.format(totalPrice);
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _getStatusColor(status),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: _getTextColor(status),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.location_on), // Icon for depart
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(departCode),
                    Text(depart),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_right_alt),
                Spacer(),
                Icon(Icons.location_on), // Icon for arrive
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(arriveCode),
                    Text(arrive),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mã đơn hàng: $id',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  formattedPrice, // Sử dụng biến đã được định dạng
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18, // Kích thước chữ lớn hơn
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
