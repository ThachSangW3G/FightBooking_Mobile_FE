import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/seat.dart';

class SeatGridView extends StatelessWidget {
  final Map<String, Seat> seats;
  final List<String> selectedSeats;
  final Function(String) onSeatTap;
  final Color Function(Seat, String) getSeatColor;

  SeatGridView({
    required this.seats,
    required this.selectedSeats,
    required this.onSeatTap,
    required this.getSeatColor,
  });

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rows[row]!.map((seatId) {
            Seat seat = seats[seatId]!;
            return Expanded(
              child: GestureDetector(
                onTap:
                    seat.status == 'AVAILABLE' ? () => onSeatTap(seatId) : null,
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: getSeatColor(seat, seatId),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                  ),
                  height: 50, // Set a fixed height for seats
                  child: Center(
                    child: Text(
                      seatId,
                      style: TextStyle(color: Colors.white),
                    ),
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
