import 'dart:convert';
import 'dart:async';
import 'package:flightbooking_mobile_fe/controllers/flight_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/passenger_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/seat_class_controller.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';

import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';
import 'package:flightbooking_mobile_fe/models/flights/flight.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/screens/info_guest/info_guest_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/services/flight_service.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/seat/seat_selection_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TripSummaryScreen extends StatefulWidget {
  const TripSummaryScreen({
    super.key,
  });

  @override
  _TripSummaryScreenState createState() => _TripSummaryScreenState();
}

class _TripSummaryScreenState extends State<TripSummaryScreen> {
  List<String> selectedDepartureSeats = [];
  List<String> selectedReturnSeats = [];
  final StreamController<double> _totalAmountController =
      StreamController<double>();

  final FlightController flightController = Get.put(FlightController());
  final PassengerController passengerController =
      Get.put(PassengerController());
  final SeatClassController seatClassController =
      Get.put(SeatClassController());

  @override
  void initState() {
    super.initState();
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
          (flightController.returnFlight.value == null ||
              selectedReturnSeats.isNotEmpty)) {
        calculateTotalAmount();
      }
    });
  }

  Future<void> calculateTotalAmount() async {
    double total = 0;
    if (flightController.departureFlight.value != null) {
      total += await fetchFlightAmount(
          flightController.departureFlight.value!.id, selectedDepartureSeats);
    }
    if (flightController.returnFlight.value != null) {
      total += await fetchFlightAmount(
          flightController.returnFlight.value!.id, selectedReturnSeats);
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
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Tóm tắt đặt chỗ', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (flightController.departureFlight.value != null)
              FlightDetails(
                flight: flightController.departureFlight.value!,
                numAdults: passengerController.adult.value,
                numChildren: passengerController.children.value,
                numInfants: passengerController.babe.value,
                selectedSeats: selectedDepartureSeats,
                seatClass: seatClassController
                    .seatClasses[seatClassController.selectedSeatClass.value]
                    .title,
                onSelect: () async {
                  int totalPassengers = passengerController.adult.value +
                      passengerController.children.value +
                      passengerController.babe.value;
                  final seats = await Get.to<List<String>>(() =>
                      SeatSelectionScreen(
                          flightId: flightController.departureFlight.value!.id,
                          numPassengers: totalPassengers));
                  if (seats != null) {
                    updateSelectedSeats(seats, true);
                  }
                },
              ),
            if (flightController.returnFlight.value != null)
              FlightDetails(
                flight: flightController.returnFlight.value!,
                numAdults: passengerController.adult.value,
                numChildren: passengerController.children.value,
                numInfants: passengerController.babe.value,
                selectedSeats: selectedReturnSeats,
                seatClass: seatClassController
                    .seatClasses[seatClassController.selectedSeatClass.value]
                    .title,
                onSelect: () async {
                  int totalPassengers = passengerController.adult.value +
                      passengerController.children.value +
                      passengerController.babe.value;

                  final seats = await Get.to<List<String>>(() =>
                      SeatSelectionScreen(
                          flightId: flightController.returnFlight.value!.id,
                          numPassengers: totalPassengers));
                  if (seats != null) {
                    updateSelectedSeats(seats, false);
                  }
                },
              ),
            const SizedBox(
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
                    const Text(
                      'Tổng cộng',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalAmount.toStringAsFixed(0)} \$',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (selectedDepartureSeats.isNotEmpty &&
                          (flightController.returnFlight.value == null ||
                              selectedReturnSeats.isNotEmpty))
                      ? () async {
                          if (flightController.departureFlight.value != null) {
                            await holdSeats(
                                flightController.departureFlight.value!.id,
                                selectedDepartureSeats);
                          }
                          if (flightController.returnFlight.value != null) {
                            await holdSeats(
                                flightController.returnFlight.value!.id,
                                selectedReturnSeats);
                          }
                          int totalPassengers =
                              passengerController.adult.value +
                                  passengerController.children.value +
                                  passengerController.babe.value;

                          Get.to(() => InfoGuestScreen(
                                numPassengers: totalPassengers,
                                totalPrice: totalAmount,
                                departureFlightId:
                                    flightController.departureFlight.value!.id,
                                returnFlightId:
                                    flightController.returnFlight.value!.id,
                              ));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Center(
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

class FlightDetails extends StatelessWidget {
  final Flight flight;
  final int? numAdults;
  final int? numChildren;
  final int? numInfants;
  final String seatClass;
  final List<String> selectedSeats;
  final VoidCallback onSelect;

  const FlightDetails({
    Key? key,
    required this.flight,
    this.numAdults,
    this.numChildren,
    this.numInfants,
    required this.selectedSeats,
    required this.onSelect,
    required this.seatClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchAdditionalFlightData(flight),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: 400,
              child: Center(child: const CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final additionalData = snapshot.data!;
          final airline = additionalData['airline'] as Airline;
          final plane = additionalData['plane'] as Plane;
          final regulation = additionalData['regulation'] as Regulation;
          final departureAirport =
              additionalData['departureAirport'] as Airport;
          final arrivalAirport = additionalData['arrivalAirport'] as Airport;
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlightInfoWidget(
                    flightName: flight.flightStatus,
                    airlineLogo: airline.logoUrl,
                    airlineName: airline.airlineName,
                    airlineNumber: plane.planeNumber,
                    seatClass: seatClass,
                    depart: departureAirport.iataCode,
                    arrive: arrivalAirport.iataCode,
                    departTime: DateFormat('HH:mm dd/MM/yyyy')
                        .format(flight.departureDate),
                    arriveTime: DateFormat('HH:mm dd/MM/yyyy')
                        .format(flight.arrivalDate),
                    totalFlight: flight.duration.toString(),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Số lượng hành khách',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Người lớn',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${numAdults ?? 0}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trẻ em',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${numChildren ?? 0}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Em bé',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${numInfants ?? 0}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Text(
                    'Ghế đã chọn',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(selectedSeats.join(', ')),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: onSelect,
                      child: const Text(
                        'Chọn ghế cho chuyến bay này',
                        style: TextStyle(color: AppColors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchAdditionalFlightData(Flight flight) async {
    final airline = await fetchAirlineByPlaneId(flight.planeId);
    final plane = await fetchPlaneNumberByPlaneId(flight.planeId);
    final regulation = await fetchRegulationByAirlineId(airline.id);
    final departureAirport = await fetchAirportById(flight.departureAirportId);
    final arrivalAirport = await fetchAirportById(flight.arrivalAirportId);

    return {
      'airline': airline,
      'plane': plane,
      'regulation': regulation,
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
    };
  }
}
