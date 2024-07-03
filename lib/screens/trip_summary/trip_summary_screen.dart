import 'dart:convert';
import 'dart:async';
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/booking_model.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/flight.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/screens/info_guest/info_guest_screen.dart';
import 'package:flightbooking_mobile_fe/widgets/flight/FlightDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/services/flight_service.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/seat/seat_selection_screen.dart';
import 'package:http/http.dart' as http;

class TripSummaryScreen extends StatefulWidget {
  final int? departureFlightId;
  final int? returnFlightId;
  final int? numAdults;
  final int? numChildren;
  final int? numInfants;

  const TripSummaryScreen({
    super.key,
    this.departureFlightId,
    this.returnFlightId,
    this.numAdults,
    this.numChildren,
    this.numInfants,
  });

  @override
  _TripSummaryScreenState createState() => _TripSummaryScreenState();
}

class _TripSummaryScreenState extends State<TripSummaryScreen> {
  Future<Flight>? departureFlightData;
  Future<Flight>? returnFlightData;
  List<String> selectedDepartureSeats = [];
  List<String> selectedReturnSeats = [];
  final StreamController<double> _totalAmountController =
      StreamController<double>();

  @override
  void initState() {
    super.initState();
    if (widget.departureFlightId != null) {
      departureFlightData = fetchFlightById(widget.departureFlightId!);
    }
    if (widget.returnFlightId != null) {
      returnFlightData = fetchFlightById(widget.returnFlightId!);
    }
  }

  @override
  void dispose() {
    _totalAmountController.close();
    super.dispose();
  }

  Future<Flight> fetchFlightById(int flightId) async {
    final response = await http.get(Uri.parse(
        'https://flightbookingbe-production.up.railway.app/flight/get-flight-by-id?id=$flightId'));
    if (response.statusCode == 200) {
      return Flight.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load flight data');
    }
  }

  void updateSelectedSeats(List<String> seats, bool isDeparture) {
    setState(() {
      if (isDeparture) {
        selectedDepartureSeats = seats;
      } else {
        selectedReturnSeats = seats;
      }
      if (selectedDepartureSeats.isNotEmpty &&
          (widget.returnFlightId == null || selectedReturnSeats.isNotEmpty)) {
        calculateTotalAmount();
      }
    });
  }

  Future<void> calculateTotalAmount() async {
    double total = 0;
    if (widget.departureFlightId != null) {
      total += await fetchFlightAmount(
          widget.departureFlightId!, selectedDepartureSeats);
    }
    if (widget.returnFlightId != null) {
      total +=
          await fetchFlightAmount(widget.returnFlightId!, selectedReturnSeats);
    }
    _totalAmountController.add(total);
  }

  Future<double> fetchFlightAmount(
      int flightId, List<String> selectedSeats) async {
    final response = await http.post(
      Uri.parse(
          'https://flightbookingbe-production.up.railway.app/booking/calculate-total-price-after-booking?flightId=$flightId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(selectedSeats),
    );

    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception('Failed to calculate total amount');
    }
  }

  Future<void> holdSeats(int flightId, List<String> seats) async {
    final response = await http.post(
      Uri.parse(
          'https://flightbookingbe-production.up.railway.app/booking/hold-seat-before-booking?flightId=$flightId'),
      body: jsonEncode(seats),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final String responseBody = response.body;
      print('Response body: $responseBody');
    } else {
      throw Exception('Failed to hold seats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        title: Text('Tóm tắt đặt chỗ', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (departureFlightData != null)
              FutureBuilder<Flight>(
                future: departureFlightData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final flight = snapshot.data!;
                    return FlightDetails(
                      flight: flight,
                      numAdults: widget.numAdults,
                      numChildren: widget.numChildren,
                      numInfants: widget.numInfants,
                      selectedSeats: selectedDepartureSeats,
                      onSelect: () async {
                        int totalPassengers = (widget.numAdults ?? 0) +
                            (widget.numChildren ?? 0) +
                            (widget.numInfants ?? 0);
                        final seats = await Get.to<List<String>>(() =>
                            SeatSelectionScreen(
                                flightId: widget.departureFlightId!,
                                numPassengers: totalPassengers));
                        if (seats != null) {
                          updateSelectedSeats(seats, true);
                        }
                      },
                    );
                  } else {
                    return Text('No data');
                  }
                },
              ),
            if (returnFlightData != null)
              FutureBuilder<Flight>(
                future: returnFlightData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final flight = snapshot.data!;
                    return FlightDetails(
                      flight: flight,
                      numAdults: widget.numAdults,
                      numChildren: widget.numChildren,
                      numInfants: widget.numInfants,
                      selectedSeats: selectedReturnSeats,
                      onSelect: () async {
                        int totalPassengers = (widget.numAdults ?? 0) +
                            (widget.numChildren ?? 0) +
                            (widget.numInfants ?? 0);
                        final seats = await Get.to<List<String>>(() =>
                            SeatSelectionScreen(
                                flightId: widget.returnFlightId!,
                                numPassengers: totalPassengers));
                        if (seats != null) {
                          updateSelectedSeats(seats, false);
                        }
                      },
                    );
                  } else {
                    return Text('No data');
                  }
                },
              ),
            SizedBox(
                height: 10), // Add some space before the total amount section
          ],
        ),
      ),
      bottomNavigationBar: StreamBuilder<double>(
        stream: _totalAmountController.stream,
        builder: (context, snapshot) {
          double totalAmount = snapshot.data ?? 0;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalAmount.toStringAsFixed(0)} ₫',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (selectedDepartureSeats.isNotEmpty &&
                          (widget.returnFlightId == null ||
                              selectedReturnSeats.isNotEmpty))
                      ? () async {
                          if (widget.departureFlightId != null) {
                            await holdSeats(widget.departureFlightId!,
                                selectedDepartureSeats);
                          }
                          if (widget.returnFlightId != null) {
                            await holdSeats(
                                widget.returnFlightId!, selectedReturnSeats);
                          }
                          int totalPassengers = (widget.numAdults ?? 0) +
                              (widget.numChildren ?? 0) +
                              (widget.numInfants ?? 0);
                          Get.to(() => InfoGuestScreen(
                                numPassengers: totalPassengers,
                                totalPrice: totalAmount,
                                departureFlightId: widget.departureFlightId!,
                                returnFlightId: widget.returnFlightId,
                                selectedDepartureSeats: selectedDepartureSeats,
                                selectedReturnSeats: selectedReturnSeats,
                              ));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Center(
                    child: Text(
                      'Thanh toán',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
