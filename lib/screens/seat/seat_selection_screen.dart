import 'dart:async';
import 'package:flightbooking_mobile_fe/components/seat/seat_grid_view.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/info_guest/info_guest_screen.dart';
import 'package:flightbooking_mobile_fe/screens/seat/seat_status_legend.dart';
import 'package:flightbooking_mobile_fe/screens/trip_summary/trip_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/services/seat_service.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/seat.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeatSelectionScreen extends StatefulWidget {
  final int flightId;
  final int numPassengers;

  const SeatSelectionScreen(
      {super.key, required this.flightId, required this.numPassengers});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late Future<Map<String, Seat>> seats;
  List<String> selectedSeats = [];
  Timer? holdTimer;

  @override
  void initState() {
    super.initState();
    seats = fetchSeats(widget.flightId);
  }

  void selectSeat(String seatId) {
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else if (selectedSeats.length < widget.numPassengers) {
        selectedSeats.add(seatId);
      }
    });
  }

  Color getSeatColor(Seat seat, String seatId) {
    if (seat.status == null) {
      return Colors.grey; // Xử lý trường hợp status là null
    } else if (seat.status == 'BOOKED') {
      return Colors.yellow;
    } else if (seat.status == "ON_HOLD") {
      return Colors.green;
    } else if (selectedSeats.contains(seatId)) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text('Chọn chỗ ngồi', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, Seat>>(
        future: seats,
        builder: (context, snapshot) {
          //Ở phần này thêm mấy cái chú thích là màu gì đó là trạng thái ghế như thế nào để người dùng còn biết đường

          //
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final seats = snapshot.data!;
            return Column(
              children: [
                SeatStatusLegend(),
                Expanded(
                  child: SeatGridView(
                    seats: seats,
                    selectedSeats: selectedSeats,
                    onSeatTap: selectSeat,
                    getSeatColor: getSeatColor,
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedSeats.length == widget.numPassengers
            ? () {
                Navigator.pop(context, selectedSeats.toList());
              }
            : null,
        label: const Text('Xác nhận'),
        icon: const Icon(Icons.check),
        backgroundColor: selectedSeats.length == widget.numPassengers
            ? Colors.blue
            : Colors.grey,
      ),
    );
  }
}
