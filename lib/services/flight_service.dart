import 'dart:convert';
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/flight.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';
import 'package:http/http.dart' as http;

Future<Flight> fetchFlightById(int flightId) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.6:7050/flight/get-flight-by-id?id=$flightId'));

  if (response.statusCode == 200) {
    final flight = Flight.fromJson(jsonDecode(response.body));
    print("Flight: $flight");
    return flight;
  } else {
    throw Exception('Failed to load flight');
  }
}

Future<Airline> fetchAirlineByPlaneId(int planeId) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.6:7050/airlines/get-airline-by-planeId?planeId=$planeId'));

  if (response.statusCode == 200) {
    final airline = Airline.fromJson(jsonDecode(response.body));
    print("Airline: $airline");
    return airline;
  } else {
    throw Exception('Failed to load plane');
  }
}

Future<Regulation> fetchRegulationByAirlineId(int airlineId) async {
  final response = await http.get(
      Uri.parse('http://192.168.1.6:7050/regulations/byAirline/$airlineId'));

  if (response.statusCode == 200) {
    final regulation = Regulation.fromJson(jsonDecode(response.body));
    print("Regulation: $regulation");
    return regulation;
  } else {
    throw Exception('Failed to load airline');
  }
}

Future<Plane> fetchPlaneNumberByPlaneId(int planeId) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.6:7050/airlines/get-plane-detail-by-planeId?planeId=$planeId'));

  if (response.statusCode == 200) {
    final plane = Plane.fromJson(jsonDecode(response.body));
    print("Plane: $plane");
    return plane;
  } else {
    throw Exception('Failed to load plane');
  }
}

Future<Airport> fetchAirportById(int airportId) async {
  final response =
      await http.get(Uri.parse('http://192.168.1.6:7050/airports/$airportId'));

  if (response.statusCode == 200) {
    final airport = Airport.fromJson(jsonDecode(response.body));
    print("Airport: $airport");
    return airport;
  } else {
    throw Exception('Failed to load airline');
  }
}
