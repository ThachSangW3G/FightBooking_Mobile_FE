import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/seat.dart';

class SeatGridView extends StatelessWidget {
  final Map<String, Seat> seats;

  SeatGridView({required this.seats});

  @override
  Widget build(BuildContext context) {
    // Group seats by row
    Map<String, List<String>> rows = {};
    seats.forEach((key, value) {
      String row = key.substring(0, 1);
      if (!rows.containsKey(row)) {
        rows[row] = [];
      }
      rows[row]!.add(key);
    });

    return ListView(
      children: rows.keys.map((row) {
        return Row(
          children: rows[row]!.map((seatId) {
            Seat seat = seats[seatId]!;
            return Expanded(
              child: GestureDetector(
                onTap: seat.status == 'AVAILABLE'
                    ? () {
                        // Handle seat selection
                        print('Selected seat $seatId');
                      }
                    : null,
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  color: seat.status == 'AVAILABLE' ? Colors.green : Colors.red,
                  child: Center(
                    child: Text(seatId),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
