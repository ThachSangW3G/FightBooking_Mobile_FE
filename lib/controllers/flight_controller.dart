import 'package:flightbooking_mobile_fe/models/airport.dart';
import 'package:flightbooking_mobile_fe/models/flight.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlightSearchController extends GetxController {
  static const String _baseUrl =
      'https://flightbookingbe-production.up.railway.app';

  final flights = <Flight>[].obs;

  Future<void> searchFlightOneWay(
    Airport departureAirport,
    Airport arrivalAirport,
    DateTime departureDate,
  ) async {
    try {
      String formatDepartureDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(departureDate);
      String arrivalAirportId = arrivalAirport.id.toString();
      String departureAirportId = departureAirport.id.toString();

      Uri uri = Uri.parse(
          '$_baseUrl/flight/search-flight-by-type?ROUND_TRIP%20or%20ONE_WAY=ONE_WAY&departureAirportId=$departureAirportId&arrivalAirportId=$arrivalAirportId&departureDate=$formatDepartureDate');
      print(uri);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Flight> fetchedFlights =
            data.map((json) => Flight.fromJson(json)).toList();
        flights.assignAll(fetchedFlights); // Cập nhật danh sách chuyến bay
      } else {
        throw Exception('Failed to load flights');
      }
    } catch (e) {
      print('Error fetching flights: $e');
      throw e;
    }
  }

  Future<void> searchFlightRoundTrip(
    Airport departureAirport,
    Airport arrivalAirport,
    DateTime departureDate,
    DateTime returnDate,
  ) async {
    try {
      String formatDepartureDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(departureDate);
      String formatReturnDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(returnDate);
      String arrivalAirportId = arrivalAirport.id.toString();
      String departureAirportId = departureAirport.id.toString();
      Uri uri = Uri.parse(
          '$_baseUrl/flight/search-flight-by-type?ROUND_TRIP%20or%20ONE_WAY=ONE_WAY&departureAirportId=$departureAirportId&arrivalAirportId=$arrivalAirportId&departureDate=$formatDepartureDate&returnDate=$formatReturnDate');

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Flight> fetchedFlights =
            data.map((json) => Flight.fromJson(json)).toList();
        flights.assignAll(fetchedFlights); // Cập nhật danh sách chuyến bay
      } else {
        throw Exception('Failed to load flights');
      }
    } catch (e) {
      print('Error fetching flights: $e');
      throw e;
    }
  }
}
