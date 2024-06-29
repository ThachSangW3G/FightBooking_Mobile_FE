import 'dart:convert';

import 'package:flightbooking_mobile_fe/models/flights/flight.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FlightController extends GetxController {
  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  var departureFlight = Rx<Flight?>(null);
  var returnFlight = Rx<Flight?>(null);

  Future<List<Flight>> filterFlights(DateTime departureDate,
      int departureAirportId, int arrivalAirportId) async {
    final formatDepartureDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(departureDate);

    final uri = Uri.parse(
        '$_baseURL/flight/filter-flights?flightType=ONE_WAY&departureDate=$formatDepartureDate&departureAirportId=$departureAirportId&arrivalAirportId=$arrivalAirportId&classType=economy&order=asc');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

        print(jsonData);

        final List<Flight> flights = [];
        jsonData.forEach((element) {
          final id = element['id'];

          final departureDate = DateTime(element['departureDate']);

          final arrivalDate = DateTime(element['arrivalDate']);
          print(arrivalDate);
          final departureAirportId = element['departureAirportId'];
          final arrivalAirportId = element['arrivalAirportId'];
          final planeId = element['planeId'];
          final economyPrice = element['economyPrice'];
          final businessPrice = element['businessPrice'];
          final firstClassPrice = element['firstClassPrice'];
          final flightStatus = element['flightStatus'];

          final flight = Flight(
            id: id,
            flightStatus: flightStatus,
            departureDate: departureDate,
            arrivalDate: arrivalDate,
            departureAirportId: departureAirportId,
            arrivalAirportId: arrivalAirportId,
            planeId: planeId,
            economyPrice: economyPrice,
            businessPrice: businessPrice,
            firstClassPrice: firstClassPrice,
          );
          print(flight);

          flights.add(flight);
        });

        return flights;
      } else {
        throw Exception('Failed to load flights');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load flights');
    }
  }

  void setDepartureFlight(Flight flight) {
    departureFlight.value = flight;
  }

  void setReturnFlight(Flight flight) {
    returnFlight.value = flight;
  }

  int getNumberFlightSelected() {
    if (departureFlight.value != null && returnFlight.value != null) {
      return 2;
    } else if (departureFlight.value != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
