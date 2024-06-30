
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/flight.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_info_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/services/flight_service.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/seat/seat_selection_screen.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
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
                    return FlightDetails(flight: flight);
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
                    return FlightDetails(flight: flight);
                  } else {
                    return Text('No data');
                  }
                },
              ),
            if (widget.numAdults != null ||
                widget.numChildren != null ||
                widget.numInfants != null)
              Text(
                  'Người lớn: ${widget.numAdults ?? 0}, Trẻ em: ${widget.numChildren ?? 0}, Em bé: ${widget.numInfants ?? 0}'),
            if (widget.departureFlightId != null)
              ElevatedButton(
                onPressed: () {
                  Get.to(() =>
                      SeatSelectionScreen(flightId: widget.departureFlightId!));
                },
                child: Text('Select Seats for Departure Flight'),
              ),
            if (widget.returnFlightId != null)
              ElevatedButton(
                onPressed: () {
                  Get.to(() =>
                      SeatSelectionScreen(flightId: widget.returnFlightId!));
                },
                child: Text('Select Seats for Return Flight'),
              ),
          ],
        ),
      ),
    );
  }
}

class FlightDetails extends StatelessWidget {
  final Flight flight;

  const FlightDetails({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchAdditionalFlightData(flight),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
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
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlightInfoWidget(
                    flightName: flight.flightStatus,
                    airlineLogo: airline.logoUrl,
                    airlineName: airline.airlineName,
                    airlineNumber: plane.planeNumber,
                    seatClass: 'Economy',
                    depart: departureAirport.iataCode,
                    arrive: arrivalAirport.iataCode,
                    departTime: DateTime.fromMillisecondsSinceEpoch(
                            flight.departureDate)
                        .toString(),
                    arriveTime:
                        DateTime.fromMillisecondsSinceEpoch(flight.arrivalDate)
                            .toString(),
                    totalFlight: flight.duration.toString(),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('No data');
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
