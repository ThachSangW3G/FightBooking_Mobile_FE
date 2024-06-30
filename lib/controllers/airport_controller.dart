import 'package:flightbooking_mobile_fe/models/airport.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get/get.dart';

class AirportController extends GetxController {
  var airports = <Airport>[].obs;
  var selectedDepartureAirport = Rx<Airport?>(null);
  var selectedDestinationAirport = Rx<Airport?>(null);

  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  @override
  void onInit() {
    super.onInit();
    fetchAirports();
  }

  void fetchAirports() async {
    try {
      final response = await http.get(Uri.parse('$_baseURL/airports'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        airports.value = data.map((json) => Airport.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load airports');
      }
    } catch (e) {
      print('Error fetching airports: $e');
    }
  }

  void selectDepartureAirport(Airport airport) {
    selectedDepartureAirport.value = airport;
  }

  void selectDestinationAirport(Airport airport) {
    selectedDestinationAirport.value = airport;
  }
}
