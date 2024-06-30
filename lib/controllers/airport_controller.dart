import 'dart:convert';

import 'package:flightbooking_mobile_fe/models/airports/airport.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AirportController extends GetxController {
  var airports = Rx<List<Airport>?>(null);
  var selectedDeparture = Rx<Airport?>(null);
  var selectedDestination = Rx<Airport?>(null);
  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  Future<void> getAllAirport() async {
    final uri = Uri.parse('$_baseURL/airports');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

        print(jsonData);
        List<Airport> responseAirport = [];
        jsonData.forEach((element) {
          final id = element['id'];
          final airportName = element['airportName'];
          final city = element['city'];
          final iataCode = element['iataCode'];

          final airport = Airport(
              id: id, airportName: airportName, city: city, iataCode: iataCode);

          responseAirport.add(airport);
        });

        airports.value = responseAirport;
      }
    } catch (e) {
      print(e);
    }
  }

  void setSelectedDeparture(Airport airport) {
    if (selectedDeparture.value == airport) {
      selectedDeparture.value = null;
      return;
    }
    selectedDeparture.value = airport;
  }

  void setSelectedDestination(Airport airport) {
    if (selectedDestination.value == airport) {
      selectedDestination.value = null;
      return;
    }
    selectedDestination.value = airport;
  }

  bool swapAirport() {
    if (selectedDeparture.value != null && selectedDestination.value != null) {
      final temp = selectedDeparture.value;
      selectedDeparture.value = selectedDestination.value;
      selectedDestination.value = temp;

      return true;
    }
    return false;
  }

  Future<Airport> getAirportById(int id) async {
    final uri = Uri.parse('$_baseURL/airports/$id');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final id = jsonData['id'];
        final airportName = jsonData['airportName'];
        final city = jsonData['city'];
        final iataCode = jsonData['iataCode'];

        final airport = Airport(
            id: id, airportName: airportName, city: city, iataCode: iataCode);

        print(airport);
        return airport;
      } else {
        throw Exception('Failed to load airport');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load airport');
    }
  }
}
