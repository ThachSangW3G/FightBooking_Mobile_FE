import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/flight.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/services/flight_service.dart';
import 'package:flutter/material.dart';

class FlightDetails extends StatelessWidget {
  final Flight flight;
  final int? numAdults;
  final int? numChildren;
  final int? numInfants;
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
  }) : super(key: key);

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
                  SizedBox(height: 10),
                  Text(
                    'Số lượng hành khách',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Người lớn',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${numAdults ?? 0}',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trẻ em',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${numChildren ?? 0}',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Em bé',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${numInfants ?? 0}',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Text(
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
