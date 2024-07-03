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
    // Group seats by class and row
    Map<String, Map<String, List<String>>> classRows = {};
    seats.forEach((key, value) {
      String seatClass =
          value.seatClass.replaceAll('_', ' '); // Format class name
      String row = key.substring(0, 1);

      if (!classRows.containsKey(seatClass)) {
        classRows[seatClass] = {};
      }
      if (!classRows[seatClass]!.containsKey(row)) {
        classRows[seatClass]![row] = [];
      }
      classRows[seatClass]![row]!.add(key);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0), // Add padding to the edges
      child: ListView(
        children: classRows.keys.map((seatClass) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  seatClass,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              ...classRows[seatClass]!.keys.map((row) {
                List<String> rowSeats = classRows[seatClass]![row]!;
                int splitIndex = (rowSeats.length / 2).ceil();
                List<String> leftSeats = rowSeats.sublist(0, splitIndex);
                List<String> rightSeats = rowSeats.sublist(splitIndex);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...leftSeats.map((seatId) {
                        Seat seat = seats[seatId]!;
                        return Expanded(
                          child: GestureDetector(
                            onTap: seat.status == 'AVAILABLE' ||
                                    seat.status == 'ON_HOLD'
                                ? () => onSeatTap(seatId)
                                : null,
                            child: Container(
                              margin: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: getSeatColor(seat, seatId),
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 80, // Set a fixed height for seats
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/seat.png',
                                      height: 30),
                                  SizedBox(height: 8),
                                  Text(
                                    seatId,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      Spacer(flex: 1), // Adds space to simulate the aisle
                      ...rightSeats.map((seatId) {
                        Seat seat = seats[seatId]!;
                        return Expanded(
                          child: GestureDetector(
                            onTap: seat.status == 'AVAILABLE' ||
                                    seat.status == 'ON_HOLD'
                                ? () => onSeatTap(seatId)
                                : null,
                            child: Container(
                              margin: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: getSeatColor(seat, seatId),
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 80, // Set a fixed height for seats
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/seat.png',
                                      height: 30),
                                  SizedBox(height: 8),
                                  Text(
                                    seatId,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
