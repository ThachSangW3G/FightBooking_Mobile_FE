import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/services/seat_service.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/seat.dart';

class SeatSelectionScreen extends StatefulWidget {
  final int flightId;

  const SeatSelectionScreen({Key? key, required this.flightId})
      : super(key: key);

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late Future<Map<String, Seat>> seats;

  @override
  void initState() {
    super.initState();
    seats = fetchSeats(widget.flightId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats for Flight ${widget.flightId}'),
      ),
      body: FutureBuilder<Map<String, Seat>>(
        future: seats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final seats = snapshot.data!;
            return SeatGridView(seats: seats);
          }
        },
      ),
    );
  }
}

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
