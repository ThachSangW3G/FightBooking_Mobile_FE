// seat_status_legend.dart
import 'package:flutter/material.dart';

class SeatStatusLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(30),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(30),
          3: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              Container(width: 20, height: 20, color: Colors.yellow),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text('Ghế đã được đặt'),
              ),
              Container(width: 20, height: 20, color: Colors.green),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text('Ghế chờ thanh toán'),
              ),
            ],
          ),
          TableRow(
            children: [
              SizedBox(height: 10), // Add space between rows
              SizedBox(height: 10),
              SizedBox(height: 10),
              SizedBox(height: 10),
            ],
          ),
          TableRow(
            children: [
              Container(width: 20, height: 20, color: Colors.blue),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text('Ghế mà bạn chọn'),
              ),
              Container(width: 20, height: 20, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text('Ghế đang trống'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
